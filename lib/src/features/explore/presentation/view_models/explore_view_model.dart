import 'dart:collection';

import 'package:aider_mobile_app/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../../product/domain/models/category/category_model.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../../data/repositories/explore_repository.dart';


class ExploreViewModel extends BaseViewModel{
  final _exploreRepository = sl.get<ExploreRepository>();

  List _sections = [];
  int _sectionCurrentPageNumber = 1;
  bool _hasNoSectionData = false;
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<ProductModel> _categoryProducts = [];


  int get getSectionCurrentPageNumber => _sectionCurrentPageNumber;
  bool get hasNoSectionData => _hasNoSectionData;

  UnmodifiableListView get getSections => UnmodifiableListView(_sections);

  void setSections(List data, {bool append = false}){
    if(append){
      _sections.addAll(data);
    }else{
      _sections = data;
    }
  }

  Future<void> fetchSections(BuildContext context,{required Map<String, dynamic> queryParams}) async{
    setComponentErrorType = null;
    if(queryParams['page'] == 1){
      _sectionCurrentPageNumber = 1;
      _hasNoSectionData=false;
    }
    setLoading(true, component: 'sections');

    final result = await _exploreRepository.fetchSections(queryParams: queryParams);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'sections'
      };
      setLoading(false, component: 'sections');

    }, (right) {
      _sectionCurrentPageNumber = queryParams['page'] + 1;
      _hasNoSectionData = right.length < kSectionPerPage;
      setSections(right, append: queryParams['page']>1);
      setLoading(false, component: 'sections',);
    });
  }

  UnmodifiableListView<CategoryModel> get getCategories => UnmodifiableListView(_categories);

  void setCategories(List<CategoryModel> data, {bool append = false}){
    if(append){
      _categories.addAll(data);
    }else{
      _categories = data;
    }
  }

  int _categoryCurrentPageNumber = 1;
  bool _categoryHasNoData = false;
  int get getCategoriesPageNumber => _categoryCurrentPageNumber;
  bool get hasNoCategoryData => _categoryHasNoData;

  Future<void> fetchCategories(BuildContext context, {required String sectionExternalId, required Map<String, dynamic> queryParams}) async{
    setComponentErrorType = null;
    if(queryParams['page'] == 1){
      _categoryCurrentPageNumber = 1;
      clearCategories();
      _categoryHasNoData=false;
    }
    setLoading(true, component: 'categories');

    final result = await _exploreRepository.fetchCategories(sectionExternalId: sectionExternalId, queryParams: queryParams);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'categories',
      };
      setLoading(false, component: 'categories');

    }, (right) {
      _categoryCurrentPageNumber = queryParams['page'] + 1;
      _categoryHasNoData = right.length < kDataPerPage;
      setCategories(right, append: queryParams['page']>1);
      setLoading(false, component: 'categories',);
    });
  }

  void clearCategories(){
    _categories.clear();
  }


  UnmodifiableListView<ProductModel> get getProducts => UnmodifiableListView(_products);

  void setProducts(List<ProductModel> data, {bool append = false}){
    if(append){
      _products.addAll(data);
    }else{
      _products = data;
    }
  }

  int _productCurrentPageNumber = 1;
  bool _productHasNoData = false;
  int get getProductsPageNumber => _productCurrentPageNumber;
  bool get hasNoProductData => _productHasNoData;

  Future<void> fetchProducts(BuildContext context, {required String sectionExternalId, required Map<String, dynamic> queryParams}) async{
    setComponentErrorType = null;
    if(queryParams['page'] == 1){
      _productCurrentPageNumber = 1;
      clearProducts();
      _productHasNoData=false;
    }
    setLoading(true, component: 'products');

    final result = await _exploreRepository.fetchProducts(sectionExternalId: sectionExternalId, queryParams: queryParams);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'products',
      };
      setLoading(false, component: 'products');

    }, (right) {
      _productCurrentPageNumber = queryParams['page'] + 1;
      _productHasNoData = right.length < kProductPerPage;
      setProducts(right, append: queryParams['page']>1);
      setLoading(false, component: 'products',);
    });
  }

  void clearProducts(){
    _products.clear();
  }

  int _categoryProductCurrentPageNumber = 1;
  bool _categoryProductHasNoData = false;
  UnmodifiableListView<ProductModel> get getCategoryProducts => UnmodifiableListView(_categoryProducts);
  int get getCategoryProductListCurrentPageNumber => _categoryProductCurrentPageNumber;
  bool get categoryProductHasNoData => _categoryProductHasNoData;

  void setCategoryProductCurrentPageNumber(int page){
    _categoryProductCurrentPageNumber = page;
  }

  void setCategoryProductsHasNoData(bool hasData){
    _categoryProductHasNoData = hasData;
  }


  void setCategoryProducts(List<ProductModel> data, {bool append = false,}){
    if(append){
      _categoryProducts.addAll(data);
    }else{
      _categoryProducts = data;
    }
  }

  /// FETCH PRODUCTS BY CATEGORY
  Future<void> fetchProductsByCategory(BuildContext context, {required String categoryExternalId, String loadingComponent = 'fetchProductsByCategory', required Map<String, dynamic> queryParams}) async{
    setComponentErrorType = null;
    if(queryParams['page'] == 1){
      _categoryProductCurrentPageNumber = 1;
      clearCategoryProducts();
      _categoryProductHasNoData=false;
    }
    setLoading(true, component: loadingComponent);

    final result = await _exploreRepository.fetchProductsByCategory(categoryExternalId: categoryExternalId, queryParams: queryParams);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);

    }, (right) {
      _categoryProductCurrentPageNumber = queryParams['page'] + 1;
      _categoryProductHasNoData = right.length < kProductPerPage;
      setCategoryProducts(right, append: queryParams['page']>1);
      setLoading(false, component: loadingComponent,);
    });
  }

  ///FILTER
  Future<void> fetchFilteredProducts(BuildContext context,{ required String type, required Map<String, dynamic> requestBody,
    String? loadingComponent,
    required Map<String, dynamic> queryParam}) async{
    if(type == 'fetchProductsByCategory'){
      setComponentErrorType = null;
      // clearCategoryProducts();
      _categoryProductHasNoData=false;
      setLoading(true, component: 'fetchProductsByCategory');
      if(loadingComponent == 'fetchProductsByCategory'){
        AppDialogUtil.loadingDialog(context);
      }
      final result = await _exploreRepository.fetchFilteredProducts(requestBody: requestBody, queryParams: queryParam);
      if(context.mounted) {AppNavigator.pop(context);}

      result.fold((failure){
        WidgetsBinding.instance.addPostFrameCallback((_) async{
          AppDialogUtil.popUpModal(
            context,
            modalContent: ErrorModalContent(
              errorMessage: FailureToMessage.mapFailureToMessage(failure),
            ),
          );
          setLoading(false, component: 'loadingComponent');
        });
      }, (right){
        _categoryProductHasNoData = right.length < kProductPerPage;
        setCategoryProducts(right);
        setLoading(false, component: 'loadingComponent');
        AppNavigator.pop(context);
      });
    }else{
      setComponentErrorType = null;
      if(queryParam['page'] == 1){
        _productCurrentPageNumber = 1;
        clearProducts();
        _productHasNoData=false;
      }
      setLoading(true, component: 'products');
      if(loadingComponent == 'products'){
        AppDialogUtil.loadingDialog(context);
      }
      final result = await _exploreRepository.fetchFilteredProducts(requestBody: requestBody, queryParams: queryParam);
      if(context.mounted) {AppNavigator.pop(context);}

      result.fold((failure){
        WidgetsBinding.instance.addPostFrameCallback((_) async{
          AppDialogUtil.popUpModal(
            context,
            modalContent: ErrorModalContent(
              errorMessage: FailureToMessage.mapFailureToMessage(failure),
            ),
          );
          setLoading(false, component: 'products');
        });
      }, (right){
        _productHasNoData = right.length < kProductPerPage;
        setProducts(right);
        setLoading(false, component: 'products',);
        AppNavigator.pop(context);
      });
    }
  }

  void clearCategoryProducts(){
    _categoryProducts.clear();
  }

}