import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/constants/firestore_collections.dart';
import '../../../../../core/services/remote_config_service.dart';
import '../../../product/domain/models/category/category_model.dart';
import '../../../product/domain/models/product/product_model.dart';

abstract class ExploreRemoteDatasource {
  Future<List> fetchSections({required int page, required int dataPerPage});
  Future<List<CategoryModel>> fetchCategories(
      {required String sectionExternalId,
      required int page,
      required int dataPerPage});
  Future<List<ProductModel>> fetchProducts(
      {required String sectionExternalId,
      required int page,
      required int dataPerPage});
  Future<List<ProductModel>> fetchProductsByCategory(
      {required String categoryExternalId,
      required int page,
      required int dataPerPage});
  Future<List<ProductModel>> fetchFilteredProducts(
      {required Map<String, dynamic> requestBody,
      required int page,
      required int dataPerPage});
}

class ExploreRemoteDatasourceImpl extends ExploreRemoteDatasource {
  ExploreRemoteDatasourceImpl({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<List> fetchSections(
      {required int page, required int dataPerPage}) async {
    final sections = RemoteConfigService.getRemoteData.configs['sections'];
    return (sections as List)
        .where((section) => section['live'] == true)
        .skip((page - 1) * dataPerPage)
        .take(dataPerPage)
        .toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories(
      {required String sectionExternalId,
      required int page,
      required int dataPerPage}) async {
    final response = await firestore
        .collection(kCategoriesCollection)
        .where('sectionExternalId', isEqualTo: sectionExternalId)
        .where('isActive', isEqualTo: true)
        .get();

    return response.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchProducts(
      {required String sectionExternalId,
      required int page,
      required int dataPerPage}) async {
    final response = await firestore
        .collection(kProductsCollection)
        .where('sectionExternalId', isEqualTo: sectionExternalId)
        .get();

    return response.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory(
      {required String categoryExternalId,
      required int page,
      required int dataPerPage}) async {
    final response = await firestore
        .collection(kProductsCollection)
        .where('categoryExternalId', isEqualTo: categoryExternalId)
        .get();

    return response.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchFilteredProducts(
      {required Map<String, dynamic> requestBody,
      required int page,
      required int dataPerPage}) async {
    final response = await firestore
        .collection(kProductsCollection)
        .where('categoryExternalId',
            isEqualTo: requestBody['categoryExternalId'])
        .get();

    return response.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }
}
