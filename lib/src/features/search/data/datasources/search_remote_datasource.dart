import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../product/domain/models/history/product_history_model.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../../domain/models/search/search_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchModel> searchAll({required Map<String, dynamic> requestBody});
  Future<ProductHistoryModel> fetchFilteredProducts(
      {required Map<String, dynamic> requestBody,
      required Map<String, dynamic> queryParam});
  Future<ProductHistoryModel> searchAllProducts(
      {required Map<String, dynamic> requestBody,
      String? nextPage,
      required Map<String, dynamic> queryParam});
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  SearchRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  late final userCollection = firebaseFirestore.collection('users');
  late final productCollection = firebaseFirestore.collection('products');
  @override
  Future<SearchModel> searchAll(
      {required Map<String, dynamic> requestBody}) async {
    final searchTerm = requestBody['searchInput'].toString().toLowerCase();
    var users = await userCollection
        .orderBy('search')
        .startAt([searchTerm]).endAt([searchTerm + '\uf8ff']).get();

    var usersCount = users.docs.length;
    var products = await productCollection
        .orderBy('search')
        .startAt([searchTerm]).endAt([searchTerm + '\uf8ff']).get();

    var productsCount = products.docs.length;

    return SearchModel(
      users: users.docs.map((e) {
        var data = e.data();
        data['address'] = null;
        return UserModel.fromJson(data);
      }).toList(),
      products: products.docs.map((e) {
        return ProductModel.fromJson(e.data());
      }).toList(),
      vendorCount: usersCount,
      productCount: productsCount,
    );
  }

  @override
  Future<ProductHistoryModel> fetchFilteredProducts(
      {required Map<String, dynamic> requestBody,
      required Map<String, dynamic> queryParam}) async {
    final response = await productCollection
        .where('name', isEqualTo: requestBody['searchInput'])
        .get();

    var body = response.docs;

    return ProductHistoryModel.fromJson({
      'data': body.map((e) => ProductModel.fromJson(e.data())).toList(),
      'meta': body.length,
    });
  }

  @override
  Future<ProductHistoryModel> searchAllProducts(
      {required Map<String, dynamic> requestBody,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    final searchTerm = requestBody['searchInput'].toString().toLowerCase();
    final response = await productCollection
        .orderBy('search')
        .startAt([searchTerm]).endAt(['$searchTerm\uf8ff']).get();

    var body = response.docs;

    ZLoggerService.logOnInfo(
        "Search All Products Result: ${body.map((e) => e.data()).toList()}");
    return ProductHistoryModel.fromJson({
      'data': body.map((e) => e.data()).toList(),
      'meta': null,
    });
  }
}
