import 'dart:collection';

import 'package:aider_mobile_app/core/domain/models/address/address_model.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import '../../../../../core/domain/models/pagination/pagination_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/providers/base_provider.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../../data/repositories/search_repository.dart';
import '../../domain/models/search/search_model.dart';

class SearchProvider extends BaseProvider {
  final _searchRepository = sl.get<SearchRepository>();

  List<AddressModel> _address = [];
  SearchModel? _searchResult;
  bool _searchCallbackResponse = false;
  String _previousSearchText = '';
  ProductHistoryModel _products = ProductHistoryModel();

  SearchModel? get getSearchResult => _searchResult;
  bool get getSearchCallbackResponse => _searchCallbackResponse;
  String get getPreviousSearchText => _previousSearchText;

  void setSearchCallbackResponse(bool data, {notify = false}) {
    _searchCallbackResponse = data;
    if (notify) notifyListeners();
  }

  set setPreviousSearchText(String data) {
    _previousSearchText = data;
  }

  Future<void> searchAll(context,
      {required Map<String, dynamic> requestBody}) async {
    setError = null;
    setPreviousSearchText = requestBody['searchInput'] ?? '';
    setLoading(true, component: 'searchAll');
    final result = await _searchRepository.searchAll(requestBody: requestBody);

    result.fold((left) {
      setError = FailureToMessage.mapFailureToMessage(left);
      setSearchCallbackResponse(true);
      setLoading(false, component: 'searchAll');
    }, (right) {
      _searchResult = right;
      setSearchCallbackResponse(true);
      setLoading(false, component: 'searchAll');
    });
  }

  UnmodifiableListView<ProductModel> get getProducts =>
      UnmodifiableListView(_products.data);
  PaginationModel? get getProductMeta => _products.meta;

  void setSearchedProducts(ProductHistoryModel history, [bool append = false]) {
    if (append) {
      _products = _products.copyWith(
        data: List.from(_products.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _products = history;
    }
    notifyListeners();
  }

  Future<void> searchAllProducts(
    context, {
    required Map<String, dynamic> requestBody,
    String loadingComponent = 'searchAllProducts',
    required Map<String, dynamic> queryParam,
    String? nextPage,
  }) async {
    setComponentErrorType = null;
    setPreviousSearchText = requestBody['searchInput'] ?? '';
    setLoading(true, component: loadingComponent);
    final result = await _searchRepository.searchAllProducts(
        requestBody: requestBody, nextPage: nextPage, queryParam: queryParam);

    result.fold((left) {
      setComponentErrorType = {
        'component': 'searchAllProducts',
        'error': FailureToMessage.mapFailureToMessage(left),
      };
      setSearchCallbackResponse(true);
      setLoading(false, component: 'searchAllProducts');
    }, (history) {
      setSearchedProducts(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(false, component: 'searchAllProducts', notify: false);
      setSearchCallbackResponse(true);
    });
  }

  void clearAllProducts() {
    _products.data.clear();
  }

  UnmodifiableListView<AddressModel> get getAddress =>
      UnmodifiableListView(_address);

  set setPopularLocations(List<AddressModel> locations) {
    _address = locations;
    notifyListeners();
  }

  /// POPULAR LOCATIONS
  void emitPopularLocations() {
    // SocketService().emit('sendProductAddresses');
    ZLoggerService.logOnInfo('EMITTING PRODUCT ADDRESSES');
  }

  void fetchPopularLocations() {
    // SocketService().once('fetchProductAddresses', (data) {
    //   ZLoggerService.logOnInfo(
    //       'FETCHING ADDRESSES \n ---- $data ---- \n${DateTime.now()}');
    //   if (data != null) setPopularLocations = AddressList.fromJson(data).list;
    // });

    // SocketService().off('fetchProductAddresses');
  }
}
