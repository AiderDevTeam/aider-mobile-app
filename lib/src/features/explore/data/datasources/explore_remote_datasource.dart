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
  late final productsCollection = firestore.collection(kProductsCollection);

  @override
  Future<List> fetchSections(
      {required int page, required int dataPerPage}) async {
    final sections = RemoteConfigService.getRemoteData.configs['sections'];
    final liveSections = (sections as List)
        .where((section) => section['live'] == true)
        .skip((page - 1) * dataPerPage)
        .take(dataPerPage)
        .toList();

    for (var section in liveSections) {
      if (section['type'] == 'category') {
        section['data'] = loadCategories();
      }
      if (section['type'] == 'product') {
        section['data'] = await loadProducts();
      }
    }
    return liveSections;
  }

  List loadCategories() {
    final categories =
        (RemoteConfigService.getRemoteData.configs['categories'] as List)
            .take(10)
            .toList();

    return categories;
  }

  Future<List> loadProducts() async {
    final products = await productsCollection
        .where('status', isEqualTo: 'active')
        .limit(10)
        .get();

    return products.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories(
      {required String sectionExternalId,
      required int page,
      required int dataPerPage}) async {
    final categories =
        (RemoteConfigService.getRemoteData.configs['categories'] as List)
            .skip((page - 1) * dataPerPage)
            .take(dataPerPage)
            .toList();

    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchProducts(
      {required String sectionExternalId,
      required int page,
      required int dataPerPage}) async {
    final response = await firestore
        .collection(kProductsCollection)
        .where('status', isEqualTo: 'active')
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
    final categoryJson = await RemoteConfigService
        .getRemoteData.configs['categories']
        .firstWhere((category) => category['externalId'] == categoryExternalId);

    final category = CategoryModel.fromJson(categoryJson);
    List<String> subCategories = [];
    for (var subCategory in category.subCategories!) {
      for (var subCategoryItem in subCategory.subCategoryItems!) {
        if (subCategoryItem.externalId != null) {
          subCategories.add(subCategoryItem.externalId!);
        }
      }
    }

    final response = await firestore
        .collection(kProductsCollection)
        .where('status', isEqualTo: 'active')
        .where('subCategoryItemId', whereIn: subCategories)
        .get();

    ZLoggerService.logOnInfo('response: ${response.docs.length}');

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
        .where('status', isEqualTo: 'active')
        .where('categoryExternalId',
            isEqualTo: requestBody['categoryExternalId'])
        .get();

    return response.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }
}
