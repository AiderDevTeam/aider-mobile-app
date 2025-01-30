import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/errors/error.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/category/category_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product/product_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product_price/price_structure_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/constants/firestore_collections.dart';
import '../../domain/models/category/sub_category_item_model.dart';
import '../../domain/models/history/product_history_model.dart';

abstract class ProductRemoteDatasource {
  Future<void> listProduct({required ProductModel requestBody});
  Future<ProductHistoryModel> fetchUserProducts(
      {String? nextPage, int? pageSize});
  Future<bool> requestForItem(String productExternalId,
      {required Map<String, dynamic> requestBody});
  Future<bool> deleteProductPhoto(
      {required String productExternalId,
      required Map<String, dynamic> requestBody});
  Future<bool> addProductPhoto(
      {required String productExternalId,
      required Map<String, dynamic> requestBody});
  Future<bool> deleteProduct({required String productExternalId});
  Future<ProductModel> updateProduct(
      {required String productExternalId,
      required Map<String, dynamic> requestBody});
  Future<bool> deleteProductPrice(
      {required String productExternalId,
      required Map<String, dynamic> requestBody});
  Future<ProductHistoryModel> fetchVendorProducts(
      {String? vendorExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam});
  Future<List<SubCategoryItemModel>> fetchPopularSubCategoryItems();
  Future<List<SubCategoryItemModel>> fetchSubCategoryItems();
  Future<List<CategoryModel>> fetchCategories();
  Future<List<PriceStructureModel>> fetchPriceStructure();
  Future<int> fetchProductCount();
}

class ProductRemoteDatasourceImpl extends ProductRemoteDatasource {
  ProductRemoteDatasourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  late final productCollection =
      firebaseFirestore.collection(kProductsCollection);
  late final userCollection = firebaseFirestore.collection(kUsersCollection);

  @override
  Future<void> listProduct({required ProductModel requestBody}) async {
    final docRef = productCollection.doc();

    await firebaseFirestore.runTransaction((transaction) async {
      final currentLoggedInUser = await transaction
          .get(userCollection.doc(firebaseAuth.currentUser!.uid));

      if (!currentLoggedInUser.exists) {
        throw const ServerException(message: "user not found");
      }

      requestBody = requestBody.copyWith(
          userId: firebaseAuth.currentUser!.uid,
          uid: docRef.id,
          externalId: docRef.id,
          postedAt: DateTime.now().toIso8601String());

      final data = requestBody.toJson();
      data['prices'] = requestBody.prices?.map((e) => e.toJson()).toList();
      data['photos'] = requestBody.photos?.map((e) => e.toJson()).toList();
      data['address'] = requestBody.address?.toJson();

      final user = currentLoggedInUser.data() as Map<String, dynamic>;
      user['itemsListed'] = (user['itemsListed'] ?? 0) + 1;

      transaction.update(
          userCollection.doc(firebaseAuth.currentUser!.uid), user);
      transaction.set(docRef, data);
    });
  }

  @override
  Future<ProductHistoryModel> fetchUserProducts(
      {String? nextPage, int? pageSize}) async {
    Query query = productCollection.where('userId',
        isEqualTo: firebaseAuth.currentUser!.uid);
    // .orderBy('postedAt', descending: true);

    if (nextPage != null) {
      query =
          query.startAfterDocument(await productCollection.doc(nextPage).get());
    }

    final response = await query.limit(pageSize ?? kProductPerPage).get();

    return ProductHistoryModel.fromJson({
      'data':
          response.docs.map((e) => (e.data() as Map<String, dynamic>)).toList(),
      'meta': {
        'nextPage': response.docs.last.id,
      },
    });
  }

  @override
  Future<bool> requestForItem(String productExternalId,
      {required Map<String, dynamic> requestBody}) async {
    // final response = await httpServiceRequester.postRequest(
    //   endpoint: ApiRoutes.requestForItem(productExternalId),
    //   requestBody: requestBody,
    // );

    // var body = response.data;
    // if (body['success'] == false) {
    //   throw ServerException(message: body['message'] ?? '');
    // }

    return true;
  }

  @override
  Future<bool> deleteProductPhoto(
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    // await httpServiceRequester.deleteRequest(
    //   endpoint: ApiRoutes.deleteProductPhoto(productExternalId),
    //   requestBody: requestBody,
    // );

    return true;
  }

  @override
  Future<bool> addProductPhoto(
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    // await httpServiceRequester.postFormDataRequest(
    //   endpoint: ApiRoutes.addProductPhoto(productExternalId),
    //   requestBody: FormData.fromMap(requestBody),
    // );

    return true;
  }

  @override
  Future<bool> deleteProduct({required String productExternalId}) async {
    // await httpServiceRequester.deleteRequest(
    //   endpoint: ApiRoutes.deleteProduct(productExternalId),
    // );

    return true;
  }

  @override
  Future<ProductModel> updateProduct(
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    // final response = await httpServiceRequester.putRequest(
    //   endpoint: ApiRoutes.updateProduct(productExternalId),
    //   requestBody: requestBody,
    // );

    // var body = response.data;
    // if (body['success'] == false) {
    //   throw ServerException(message: body['message'] ?? '');
    // }

    // return ProductModel.fromJson(response.data['data'] ?? {});

    return ProductModel.fromJson(requestBody);
  }

  @override
  Future<bool> deleteProductPrice(
      {required String productExternalId,
      required Map<String, dynamic> requestBody}) async {
    // await httpServiceRequester.deleteRequest(
    //   endpoint: ApiRoutes.deleteProductPrice(productExternalId),
    //   requestBody: requestBody,
    // );

    return true;
  }

  @override
  Future<ProductHistoryModel> fetchVendorProducts(
      {String? vendorExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    // final response = await httpServiceRequester.getRequest(
    //     endpoint: nextPage ?? ApiRoutes.getVendorProducts(vendorExternalId),
    //     queryParam: queryParam);

    // var body = response.data;
    // if (body['success'] == false) {
    //   throw ServerException(message: body['message'] ?? '');
    // }

    // return ProductHistoryModel.fromJson({
    //   'data': body['data'] ?? [],
    //   'meta': body['meta'],
    // });

    return ProductHistoryModel.fromJson({
      'data': [],
      'meta': {},
    });
  }

  @override
  Future<List<SubCategoryItemModel>> fetchPopularSubCategoryItems() async {
    ZLoggerService.logOnDebug('fetchPopularSubCategoryItems');
    final subcategoryItems = RemoteConfigService
        .getRemoteData.configs['subCategoryItems'] as List<dynamic>;

    return subcategoryItems
        .map((e) => SubCategoryItemModel.fromJson(e))
        .take(kDataPerPage)
        .toList();
  }

  @override
  Future<List<SubCategoryItemModel>> fetchSubCategoryItems() async {
    final subcategoryItems = RemoteConfigService
        .getRemoteData.configs['subCategoryItems'] as List<dynamic>;

    return subcategoryItems
        .map((e) => SubCategoryItemModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final categories = RemoteConfigService.getRemoteData.configs['categories']
        as List<dynamic>;

    return categories.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<List<PriceStructureModel>> fetchPriceStructure() async {
    final priceStructure = RemoteConfigService
        .getRemoteData.configs['priceStructures'] as List<dynamic>;

    return priceStructure.map((e) => PriceStructureModel.fromJson(e)).toList();
  }

  @override
  Future<int> fetchProductCount() async {
    final response = await productCollection
        .where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
        .count()
        .get();

    ZLoggerService.logOnDebug('fetchProductCount: ${response.count}');
    return response.count ?? 0;
  }
}
