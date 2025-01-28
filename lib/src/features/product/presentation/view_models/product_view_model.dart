import 'dart:collection';
import 'dart:convert';

import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/services/socket_service.dart';
import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:aider_mobile_app/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/category/category_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/category/sub_category_item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/domain/models/pagination/pagination_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/utils/helper_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/providers/location_provider.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../../../shared_widgets/modals/success_modal_content.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/models/history/product_history_model.dart';
import '../../domain/models/product_price/price_structure_model.dart';
import '../../domain/models/product/product_model.dart';
import 'can_rent_mixin.dart';

class ProductViewModel extends BaseProvider with CanRent {
  final _productRepository = sl.get<ProductRepository>();
  Map<String, dynamic> _productRequestBody = {};
  String _categoryModalTitle = '';
  List<PriceStructureModel> _priceStructure = [];
  ProductHistoryModel _userProductHistory = const ProductHistoryModel();
  ProductHistoryModel _vendorProductHistory = const ProductHistoryModel();
  List<CategoryModel> _categories = [];
  List<SubCategoryItemModel> _subCategoryItems = [];
  CategoryModel _selectedCategory = const CategoryModel();
  Map<String, dynamic> _productDescription = {};

  set setProductDescription(Map<String, dynamic> userInput) {
    _productDescription = {..._productDescription, ...userInput};
  }

  UnmodifiableMapView<String, dynamic> get getProductDescription =>
      UnmodifiableMapView(_productDescription);

  void clearProductDescription() {
    _productDescription.clear();
  }

  set setProductRequestBody(Map<String, dynamic> request) {
    _productRequestBody = {..._productRequestBody, ...request};
  }

  UnmodifiableMapView<String, dynamic> get getProductRequestBody =>
      UnmodifiableMapView(_productRequestBody);

  void setModalWithCategory(CategoryModel categoryModel,
      [bool notify = false]) {
    _categoryModalTitle = categoryModel.name ?? '';
    _selectedCategory = categoryModel;
  }

  String get getCategoryModalTitle => _categoryModalTitle;

  CategoryModel get getSelectedCategory => _selectedCategory;

  /// LIST A PRODUCT
  Future<void> listProduct(BuildContext context,
      {required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    if ((requestBody['photos[]'] ?? []).length > 0) {
      List images = [];
      for (final filePath in requestBody['photos[]']) {
        final imagePath = await MediaFileUtil.getMultipartFile(filePath);
        if (imagePath != null) images.add(imagePath);
      }
      requestBody['photos[]'] = images;
    }

    if (requestBody['address'] == null) requestBody.remove('address');

    if (context.mounted &&
        requestBody['address'] != null &&
        (requestBody['address']['placeId'] != null &&
            requestBody['address']['placeId'].toString().isNotEmpty)) {
      final locationDetails = await context
          .read<LocationProvider>()
          .fetchLocationDetails(requestBody['address']['placeId']);
      final locality = HelperUtil.getLocalityFromAddressComponents(
          locationDetails?.addressComponents ?? []);
      final address = {
        "latitude": locationDetails?.geometry?['location']['lat'] ?? 0,
        "longitude": locationDetails?.geometry?['location']['lng'] ?? 0,
        "country": "Nigeria",
        "countryCode": 'NG',
        "originName": requestBody['address']['originName'],
        "city": locality.first.isEmpty
            ? requestBody['address']['originName']
            : locality.first
      };

      requestBody["address"] = jsonEncode(address);
    }

    final result =
        await _productRepository.listProduct(requestBody: requestBody);
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
      });
    }, (product) {
      AppDialogUtil.showSuccessAlert(
        context,
        'Item listed',
        alignment: Alignment(0.0, HelperUtil.isIOS ? -0.88 : -0.90),
      );
      AppNavigator.pushNamed(context, AppRoute.listedProductsScreen,
          arguments: true);
      clearProductDescription();
    });
  }

  /// USER PRODUCTS
  void setUserProductHistory(ProductHistoryModel history,
      [bool append = false]) {
    if (append) {
      _userProductHistory = _userProductHistory.copyWith(
        data: List.from(_userProductHistory.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _userProductHistory = history;
    }
  }

  UnmodifiableListView<ProductModel> get getProducts =>
      UnmodifiableListView(_userProductHistory.data);
  PaginationModel? get getProductMeta => _userProductHistory.meta;

  Future<void> fetchUserProducts(BuildContext context,
      {required Map<String, dynamic> queryParam,
      String loadingComponent = 'fetchProducts',
      String? nextPage}) async {
    setComponentErrorType = null;
    setLoading(true, component: loadingComponent);

    final result = await _productRepository.fetchUserProducts(
        nextPage: nextPage, queryParam: queryParam);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (history) {
      setUserProductHistory(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
      if (history.meta?.currentPage == 1) _persistUserProductHistory();
    });
  }

  /// RENTING
  Future<void> requestForItem(BuildContext context, String productExternalId,
      {required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);
    if (context.mounted &&
        (context.read<ProductViewModel>().getPlaceId.isNotEmpty &&
            context.read<ProductViewModel>().getPlaceId.isNotEmpty)) {
      final locationDetails = await context
          .read<LocationProvider>()
          .fetchLocationDetails(context.read<ProductViewModel>().getPlaceId);
      // final locality = HelperUtil.getLocalityFromAddressComponents(locationDetails?.addressComponents?? []);
      final longAndLat = {
        "latitude": locationDetails?.geometry?['location']['lat'] ?? 0,
        "longitude": locationDetails?.geometry?['location']['lng'] ?? 0,
      };

      requestBody["exchangeSchedule"] = {
        ...context.read<ProductViewModel>().getLocation,
        ...longAndLat,
        "timeOfExchange": context.read<ProductViewModel>().getTimeOfExchange
      };
    }
    final result = await _productRepository.requestForItem(productExternalId,
        requestBody: requestBody);
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
      });
    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Renting Request',
          message: 'Your request has been submitted. Wait for confirmation',
          onButtonPressed: () {
            context.read<BottomNavViewModel>().selectNavTab = 3;
            AppNavigator.of(context)
              ..pop()
              ..pushNamedAndRemoveUntil(AppRoute.homeScreen, (route) => false);
          },
        ),
      );
    });
  }

  /// PRODUCT PHOTOS
  Future<bool> deleteProductPhoto(BuildContext context,
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);
    final result = await _productRepository.deleteProductPhoto(
        productExternalId: productExternalId, requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    bool response = false;

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
      response = false;
    }, (right) {
      final index = _userProductHistory.data
          .indexWhere((obj) => obj.externalId == productExternalId);
      if (index >= 0) {
        final userProduct = _userProductHistory.data[index].copyWith(
            photos: List.from(_userProductHistory.data[index].photos ?? [])
              ..removeWhere((obj) => obj.id == requestBody['photoId']));

        List<ProductModel> products = List.from(_userProductHistory.data);
        products[index] = userProduct;
        final history = _userProductHistory.copyWith(
          data: products,
        );

        _userProductHistory = history;
        notifyListeners();
      }
      response = right;
      AppDialogUtil.showSuccessAlert(
        context,
        'Photo deleted',
        alignment: Alignment(0.0, HelperUtil.isIOS ? -0.88 : -0.90),
      );
    });

    return response;
  }

  Future<void> addProductPhoto(BuildContext context,
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    final imagePath =
        await MediaFileUtil.getMultipartFile(requestBody['photos[]']);
    requestBody['photos[]'] = [imagePath];

    final result = await _productRepository.addProductPhoto(
        productExternalId: productExternalId, requestBody: requestBody);
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
      });
    }, (right) {
      AppDialogUtil.showSuccessAlert(
        context,
        'Photo uploaded',
        alignment: Alignment(0.0, HelperUtil.isIOS ? -0.88 : -0.90),
      );
    });
  }

  /// DELETE PRODUCT
  Future<void> deleteProduct(BuildContext context,
      {bool fromCloset = false, String productExternalId = ''}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _productRepository.deleteProduct(
      productExternalId: productExternalId,
    );

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      if (right) {
        final history = _userProductHistory.copyWith(
            data: List.from(_userProductHistory.data)
              ..removeWhere((obj) => obj.externalId == productExternalId));
        _userProductHistory = history;
        notifyListeners();

        AppDialogUtil.popUpModal(
          context,
          modalContent: SuccessModalContent(
            title: 'Item deleted',
            message: '',
            onButtonPressed: () {
              AppNavigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        );
      }
    });
  }

  /// PRODUCT UPDATE
  Future<void> updateProduct(BuildContext context,
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    if (context.mounted &&
        requestBody['address'] != null &&
        (requestBody['address']['placeId'] != null &&
            requestBody['address']['placeId'].toString().isNotEmpty)) {
      final locationDetails = await context
          .read<LocationProvider>()
          .fetchLocationDetails(requestBody['address']['placeId']);
      final locality = HelperUtil.getLocalityFromAddressComponents(
          locationDetails?.addressComponents ?? []);
      final address = {
        "latitude": locationDetails?.geometry?['location']['lat'] ?? 0,
        "longitude": locationDetails?.geometry?['location']['lng'] ?? 0,
        "country": "Nigeria",
        "countryCode": 'NG',
        "originName": requestBody['address']['originName'],
        "city": locality.first.isEmpty
            ? requestBody['address']['originName']
            : locality.first
      };

      requestBody["address"] = address;
    }

    final result = await _productRepository.updateProduct(
        productExternalId: productExternalId, requestBody: requestBody);
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
      });
    }, (product) {
      final index = _userProductHistory.data
          .indexWhere((obj) => obj.externalId == productExternalId);
      if (index >= 0) {
        List<ProductModel> products = List.from(_userProductHistory.data);
        products[index] = product;
        _userProductHistory = _userProductHistory.copyWith(
          data: products,
        );

        notifyListeners();
      }

      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Item updated',
          message: '',
          onButtonPressed: () {
            AppNavigator.of(context)
              ..pop()
              ..pop();
          },
        ),
      );
    });
  }

  /// DELETE PRODUCT PRICE
  Future<bool> deleteProductPrice(BuildContext context,
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _productRepository.deleteProductPrice(
        productExternalId: productExternalId, requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    bool response = false;

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
      response = false;
    }, (right) {
      response = true;
      final index = _userProductHistory.data
          .indexWhere((obj) => obj.externalId == productExternalId);
      if (index >= 0) {
        final newProduct = _userProductHistory.data[index].copyWith(
          prices: List.from(_userProductHistory.data[index].prices ?? [])
            ..removeWhere((obj) => obj.id == requestBody['productPriceId']),
        );
        List<ProductModel> products = List.from(_userProductHistory.data);
        products[index] = newProduct;
        _userProductHistory = _userProductHistory.copyWith(
          data: products,
        );
        notifyListeners();
      }

      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Price deleted',
          message: '',
          onButtonPressed: () {
            AppNavigator.of(context).pop();
          },
        ),
      );
    });
    return response;
  }

  /// VENDOR PRODUCTS
  void setVendorProductHistory(ProductHistoryModel history,
      [bool append = false]) {
    if (append) {
      _vendorProductHistory = _vendorProductHistory.copyWith(
        data: List.from(_vendorProductHistory.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _vendorProductHistory = history;
    }
  }

  UnmodifiableListView<ProductModel> get getVendorProducts =>
      UnmodifiableListView(_vendorProductHistory.data);
  PaginationModel? get getVendorProductMeta => _vendorProductHistory.meta;

  Future<void> fetchVendorProducts(BuildContext context,
      {String? vendorExternalId,
      required Map<String, dynamic> queryParam,
      String loadingComponent = 'fetchVendorProducts',
      String? nextPage}) async {
    setComponentErrorType = null;
    if (nextPage == null) {
      _vendorProductHistory = const ProductHistoryModel();
    }
    setLoading(true, component: loadingComponent);

    final result = await _productRepository.fetchVendorProducts(
        vendorExternalId: vendorExternalId,
        nextPage: nextPage,
        queryParam: queryParam);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (history) {
      setVendorProductHistory(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }

  /// PRICE STRUCTURE
  UnmodifiableListView<PriceStructureModel> get getPriceStructure =>
      UnmodifiableListView(_priceStructure);

  set setPriceStructure(List<PriceStructureModel> priceStructure) {
    _priceStructure = priceStructure;
    notifyListeners();
    _persistPriceStructure();
  }

  Future<void> _persistPriceStructure() async {
    final _ = await _productRepository.persistPriceStructure(_priceStructure);
  }

  Future<void> retrievePriceStructure([bool notify = true]) async {
    final result = await _productRepository.retrievePriceStructure();
    result.fold((l) => null, (priceStructureList) {
      _priceStructure = priceStructureList;
      if (notify) notifyListeners();
    });
  }

  void emitPriceStructure() {
    SocketService().emit('sendPriceStructure');
    ZLoggerService.logOnInfo('EMITTING PRICE STRUCTURE');
  }

  void fetchPriceStructure() {
    SocketService().once('fetchPriceStructure', (data) {
      ZLoggerService.logOnInfo(
          'FETCHING PRICE STRUCTURE \n ---- $data ---- \n${DateTime.now()}');
      if (data != null)
        setPriceStructure = PriceStructureList.fromJson(data).list;
    });

    SocketService().off('fetchPriceStructure');
  }

  /// SUB CATEGORIES
  UnmodifiableListView<CategoryModel> get getCategories =>
      UnmodifiableListView(_categories);

  set setCategories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  void emitCategories() {
    SocketService().emit('sendCategories');
    ZLoggerService.logOnInfo('EMITTING CATEGORIES');
  }

  void fetchCategories() {
    SocketService().once('fetchCategories', (data) {
      ZLoggerService.logOnInfo(
          'FETCHING CATEGORIES \n ---- $data ---- \n${DateTime.now()}');
      if (data != null) setCategories = CategoryList.fromJson(data).list;
    });

    SocketService().off('fetchCategories');
  }

  /// SUB CATEGORY ITEMS
  UnmodifiableListView<SubCategoryItemModel> get getSubCategoryItems =>
      UnmodifiableListView(_subCategoryItems);

  set setSubCategoryItems(List<SubCategoryItemModel> subCategoryItems) {
    _subCategoryItems = subCategoryItems;
    notifyListeners();
  }

  /// POPULAR CATEGORIES
  void emitPopularCategories([String? itemName]) {
    SocketService().emit('sendSubCategoryItems', {
      "subCategoryItemName": itemName,
    });
    ZLoggerService.logOnInfo('EMITTING SUB CATEGORY ITEMS');
  }

  void fetchPopularCategories() {
    SocketService().once('fetchSubCategoryItems', (data) {
      ZLoggerService.logOnInfo(
          'FETCHING SUB CATEGORY ITEMS \n ---- $data ---- \n${DateTime.now()}');
      if (data != null)
        setSubCategoryItems = SubCategoryItemList.fromJson(data).list;
    });

    SocketService().off('fetchSubCategoryItems');
  }

  /// LOCAL DB
  void _persistUserProductHistory() async {
    final _ =
        await _productRepository.persistUserProductHistory(_userProductHistory);
  }
}
