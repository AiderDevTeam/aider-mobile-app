import 'dart:collection';

import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:flutter/material.dart';

import '../../../../../core/auth/data/repositories/user_repository_v2.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../../product/domain/models/category/category_model.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../../data/repositories/explore_repository.dart';

class ExploreViewProvider extends BaseProvider {
  final _exploreRepository = sl.get<ExploreRepository>();
  final _userRepository = sl.get<UserRepositoryV2>();

  List _sections = [];
  int _sectionCurrentPageNumber = 1;
  bool _hasNoSectionData = false;
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<ProductModel> _categoryProducts = [];

  int get getSectionCurrentPageNumber => _sectionCurrentPageNumber;
  bool get hasNoSectionData => _hasNoSectionData;

  UnmodifiableListView get getSections => UnmodifiableListView(_sections);

  void setSections(List data, {bool append = false}) {
    if (append) {
      _sections.addAll(data);
    } else {
      _sections = data;
    }
    setSectionUserIdMap();
  }

  /// Note: in order to reduce number of database queries
  /// we are storing the product data in a map
  /// where the key is the user id and the value is the list of products reference in the section with same userId
  ///
  /// We can then set the user detail in the for products with the same userId by fetching the user detail from the database once and updating all products user
  ///
  /// so intead of fetching user detail for each product we fetch it once and update all products user where the userId is the same by using the reference
  final Map<String, List<dynamic>> _userIdToSectionProductMap = {};
  void setSectionUserIdMap() {
    for (var i = 0; i < _sections.length; i++) {
      var section = _sections[i];
      if (section['type'] == 'product') {
        for (var j = 0; j < section['data'].length; j++) {
          var product = section['data'][j];
          if (_userIdToSectionProductMap[product['userId']] == null) {
            _userIdToSectionProductMap[product['userId']] = [];
          }
          _userIdToSectionProductMap[product['userId']]!
              .add(_sections[i]['data'][j]);
        }
      }
    }

    ZLoggerService.logOnInfo(
        'userIdToSectionProductMap: $_userIdToSectionProductMap');
  }

  Future<bool> fetchProductUserDetail(BuildContext context,
      {required String uid, required String productUid}) async {
    AppDialogUtil.loadingDialog(context);
    ZLoggerService.logOnInfo('fetchProductUserDetail: $uid, $productUid');
    final result = await _userRepository.fetchUserDetailByUID(uid: uid);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    bool hasUserDetails = false;
    result.fold((failure) {
      AppDialogUtil.popUpModal(context,
          modalContent: const ErrorModalContent(
            errorMessage: "an error occurred while fetching product details",
          ));
      hasUserDetails = false;
    }, (right) {
      setProductUserDetail(right);
      hasUserDetails = true;
    });
    return hasUserDetails;
  }

  /// Note: this function is called when the user detail is fetched from the database
  /// it updates the product user detail in the map of all products with same userId by using the reference
  void setProductUserDetail(UserModel user) {
    ZLoggerService.logOnInfo('setProductUserDetail: $user');
    final productsWithUser = _userIdToSectionProductMap[user.uid];
    print('productsWithUser before setting: $productsWithUser');
    if (productsWithUser != null) {
      for (var product in productsWithUser) {
        user = user.copyWith(addresses: null);
        product['user'] = user.toJson();
      }
    }
    print('productsWithUser after setting: $_userIdToSectionProductMap');
    notifyListeners();
  }

  Future<ProductModel?> getProductByUserIdAndProductUid(
      BuildContext context, String userId, String productUid) async {
    final productsWithUser = _userIdToSectionProductMap[userId];
    if (productsWithUser != null) {
      for (var i = 0; i < productsWithUser.length; i++) {
        var product = productsWithUser[i];
        if (product['uid'] == productUid) {
          if (product['user'] == null) {
            final hasUserDetails = await fetchProductUserDetail(context,
                uid: userId, productUid: productUid);
            if (!hasUserDetails) {
              return null;
            }
          }
          return ProductModel.fromJson(_userIdToSectionProductMap[userId]![i]);
        }
      }
    }
    return null;
  }

  Future<void> fetchSections(BuildContext context, {required int page}) async {
    setComponentErrorType = null;
    if (page == 1) {
      _sectionCurrentPageNumber = 1;
      _hasNoSectionData = false;
    }
    setLoading(true, component: 'sections');

    final result = await _exploreRepository.fetchSections(
        page: page, dataPerPage: kSectionPerPage);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'sections'
      };
      setLoading(false, component: 'sections');
    }, (right) {
      _sectionCurrentPageNumber = page + 1;
      _hasNoSectionData = right.length < kSectionPerPage;
      setSections(right, append: page > 1);
      setLoading(
        false,
        component: 'sections',
      );
    });
  }

  UnmodifiableListView<CategoryModel> get getCategories =>
      UnmodifiableListView(_categories);

  void setCategories(List<CategoryModel> data, {bool append = false}) {
    if (append) {
      _categories.addAll(data);
    } else {
      _categories = data;
    }
  }

  int _categoryCurrentPageNumber = 1;
  bool _categoryHasNoData = false;
  int get getCategoriesPageNumber => _categoryCurrentPageNumber;
  bool get hasNoCategoryData => _categoryHasNoData;

  Future<void> fetchCategories(BuildContext context,
      {required String sectionExternalId, required int page}) async {
    setComponentErrorType = null;
    if (page == 1) {
      _categoryCurrentPageNumber = 1;
      clearCategories();
      _categoryHasNoData = false;
    }
    setLoading(true, component: 'categories');

    final result = await _exploreRepository.fetchCategories(
        sectionExternalId: sectionExternalId,
        page: page,
        dataPerPage: kProductPerPage);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'categories',
      };
      setLoading(false, component: 'categories');
    }, (right) {
      _categoryCurrentPageNumber = page + 1;
      _categoryHasNoData = right.length < kProductPerPage;
      setCategories(right, append: page > 1);
      setLoading(
        false,
        component: 'categories',
      );
    });
  }

  void clearCategories() {
    _categories.clear();
  }

  UnmodifiableListView<ProductModel> get getProducts =>
      UnmodifiableListView(_products);

  void setProducts(List<ProductModel> data, {bool append = false}) {
    if (append) {
      _products.addAll(data);
    } else {
      _products = data;
    }
  }

  int _productCurrentPageNumber = 1;
  bool _productHasNoData = false;
  int get getProductsPageNumber => _productCurrentPageNumber;
  bool get hasNoProductData => _productHasNoData;

  Future<void> fetchProducts(BuildContext context,
      {required String sectionExternalId, required int page}) async {
    setComponentErrorType = null;
    if (page == 1) {
      _productCurrentPageNumber = 1;
      clearProducts();
      _productHasNoData = false;
    }
    setLoading(true, component: 'products');

    final result = await _exploreRepository.fetchProducts(
        sectionExternalId: sectionExternalId,
        page: page,
        dataPerPage: kProductPerPage);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'products',
      };
      setLoading(false, component: 'products');
    }, (right) {
      _productCurrentPageNumber = page + 1;
      _productHasNoData = right.length < kProductPerPage;
      setProducts(right, append: page > 1);
      setLoading(
        false,
        component: 'products',
      );
    });
  }

  void clearProducts() {
    _products.clear();
  }

  int _categoryProductCurrentPageNumber = 1;
  bool _categoryProductHasNoData = false;
  UnmodifiableListView<ProductModel> get getCategoryProducts =>
      UnmodifiableListView(_categoryProducts);
  int get getCategoryProductListCurrentPageNumber =>
      _categoryProductCurrentPageNumber;
  bool get categoryProductHasNoData => _categoryProductHasNoData;

  void setCategoryProductCurrentPageNumber(int page) {
    _categoryProductCurrentPageNumber = page;
  }

  void setCategoryProductsHasNoData(bool hasData) {
    _categoryProductHasNoData = hasData;
  }

  void setCategoryProducts(
    List<ProductModel> data, {
    bool append = false,
  }) {
    if (append) {
      _categoryProducts.addAll(data);
    } else {
      _categoryProducts = data;
    }
  }

  /// FETCH PRODUCTS BY CATEGORY
  Future<void> fetchProductsByCategory(BuildContext context,
      {required String categoryExternalId,
      String loadingComponent = 'fetchProductsByCategory',
      required int page}) async {
    setComponentErrorType = null;
    if (page == 1) {
      _categoryProductCurrentPageNumber = 1;
      clearCategoryProducts();
      _categoryProductHasNoData = false;
    }
    setLoading(true, component: loadingComponent);

    final result = await _exploreRepository.fetchProductsByCategory(
        categoryExternalId: categoryExternalId,
        page: page,
        dataPerPage: kProductPerPage);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (right) {
      _categoryProductCurrentPageNumber = page + 1;
      _categoryProductHasNoData = right.length < kProductPerPage;
      setCategoryProducts(right, append: page > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }

  ///FILTER
  Future<void> fetchFilteredProducts(
    BuildContext context, {
    required String type,
    required Map<String, dynamic> requestBody,
    String? loadingComponent,
    required int page,
  }) async {
    if (type == 'fetchProductsByCategory') {
      setComponentErrorType = null;
      // clearCategoryProducts();
      _categoryProductHasNoData = false;
      setLoading(true, component: 'fetchProductsByCategory');
      if (loadingComponent == 'fetchProductsByCategory') {
        AppDialogUtil.loadingDialog(context);
      }
      final result = await _exploreRepository.fetchFilteredProducts(
          requestBody: requestBody, page: page, dataPerPage: kProductPerPage);
      if (context.mounted) {
        AppNavigator.pop(context);
      }

      result.fold((failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          AppDialogUtil.popUpModal(
            context,
            modalContent: ErrorModalContent(
              errorMessage: FailureToMessage.mapFailureToMessage(failure),
            ),
          );
          setLoading(false, component: 'loadingComponent');
        });
      }, (right) {
        _categoryProductHasNoData = right.length < kProductPerPage;
        setCategoryProducts(right);
        setLoading(false, component: 'loadingComponent');
        AppNavigator.pop(context);
      });
    } else {
      setComponentErrorType = null;
      if (page == 1) {
        _productCurrentPageNumber = 1;
        clearProducts();
        _productHasNoData = false;
      }
      setLoading(true, component: 'products');
      if (loadingComponent == 'products') {
        AppDialogUtil.loadingDialog(context);
      }
      final result = await _exploreRepository.fetchFilteredProducts(
          requestBody: requestBody, page: page, dataPerPage: kProductPerPage);
      if (context.mounted) {
        AppNavigator.pop(context);
      }

      result.fold((failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          AppDialogUtil.popUpModal(
            context,
            modalContent: ErrorModalContent(
              errorMessage: FailureToMessage.mapFailureToMessage(failure),
            ),
          );
          setLoading(false, component: 'products');
        });
      }, (right) {
        _productHasNoData = right.length < kProductPerPage;
        setProducts(right);
        setLoading(
          false,
          component: 'products',
        );
        AppNavigator.pop(context);
      });
    }
  }

  void clearCategoryProducts() {
    _categoryProducts.clear();
  }
}
