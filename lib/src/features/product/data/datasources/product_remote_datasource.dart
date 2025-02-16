import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/errors/error.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:aider_mobile_app/core/utils/helper_util.dart';
import 'package:aider_mobile_app/src/features/inbox/domain/models/message/message_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/category/category_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product/product_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product_price/price_structure_model.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/constants/firestore_collections.dart';
import '../../domain/models/category/sub_category_item_model.dart';
import '../../domain/models/history/product_history_model.dart';
import '../../../../../core/auth/domain/models/user/user_model.dart';

abstract class ProductRemoteDatasource {
  Future<void> listProduct({required ProductModel requestBody});
  Future<ProductHistoryModel> fetchUserProducts(
      {required UserModel user, String? nextPage, int? pageSize});
  Future<String> requestForItem(ProductModel product,
      {required BookingModel booking});
  Future<bool> deleteProductPhoto(
      {required String productUid, required Map<String, dynamic> requestBody});
  Future<bool> addProductPhoto(
      {required String productUid, required Map<String, dynamic> requestBody});
  Future<bool> deleteProduct({required String productUid});
  Future<ProductModel> updateProduct(
      {required String productUid, required Map<String, dynamic> requestBody});
  Future<bool> deleteProductPrice(
      {required String productUid, required Map<String, dynamic> requestBody});
  Future<ProductHistoryModel> fetchVendorProducts(
      {required UserModel vendor,
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
  late final bookingCollection =
      firebaseFirestore.collection(kBookingsCollection);
  late final messageCollection =
      firebaseFirestore.collection(kMessagesCollection);

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
          userUid: firebaseAuth.currentUser!.uid,
          uid: docRef.id,
          externalId: docRef.id,
          postedAt: DateTime.now().toIso8601String());

      final data = requestBody.toJson();
      data['prices'] = requestBody.prices?.map((e) => e.toJson()).toList();
      data['photos'] = requestBody.photos?.map((e) => e.toJson()).toList();
      data['address'] = requestBody.address?.toJson();
      data['search'] = requestBody.name?.toLowerCase();

      transaction.update(userCollection.doc(firebaseAuth.currentUser!.uid),
          {'itemsListed': FieldValue.increment(1)});
      transaction.set(docRef, data);
    });
  }

  @override
  Future<ProductHistoryModel> fetchUserProducts(
      {required UserModel user, String? nextPage, int? pageSize}) async {
    Query query = productCollection.where('userUid', isEqualTo: user.uid);
    // .orderBy('postedAt', descending: true);

    if (nextPage != null) {
      query =
          query.startAfterDocument(await productCollection.doc(nextPage).get());
    }

    final response = await query.limit(pageSize ?? kProductPerPage).get();

    if (response.docs.isEmpty) {
      return ProductHistoryModel.fromJson({
        'data': null,
        'meta': null,
      });
    }

    return ProductHistoryModel.fromJson({
      'data': response.docs.map((e) {
        final data = (e.data() as Map<String, dynamic>);

        final jsonUser = user.toJson();
        data['user'] = jsonUser;
        return data;
      }).toList(),
      'meta': {
        'nextPage': response.docs.last.id,
      },
    });
  }

  @override
  Future<String> requestForItem(ProductModel product,
      {required BookingModel booking}) async {
    final docRef = bookingCollection.doc();

    await firebaseFirestore.runTransaction((transaction) async {
      final startDate = DateTime.parse(booking.bookedProduct?.startDate ?? '');
      final endDate = DateTime.parse(booking.bookedProduct?.endDate ?? '');
      final duration = HelperUtil.calculateBookingDuration(startDate, endDate);
      final price =
          HelperUtil.calculateProductPrice(product, duration['duration']);
      final serviceFee = num.tryParse(RemoteConfigService
              .getRemoteData.configs['settings']['service_fee'] as String) ??
          0.01;

      if (price == null) {
        throw const ServerException(message: "price not found");
      }

      final bookingPrice = price.price! * booking.bookedProduct!.quantity!;
      final collectionAmount = HelperUtil.collectionAmount(
          bookingPrice, serviceFee, duration['duration']);

      booking = booking.copyWith(
        uid: docRef.id,
        collectionAmount: collectionAmount,
        disbursementAmount: bookingPrice,
        bookingNumber: HelperUtil.generateBookingNumber(),
        bookingAcceptanceStatus: BookingProgressStatus.pending,
        status: BookingStatus.awaitingAcceptance,
        collectionStatus: BookingProgressStatus.notStarted,
        disbursementStatus: BookingProgressStatus.notStarted,
        reversalStatus: BookingProgressStatus.notStarted,
        vendorPickupStatus: BookingProgressStatus.notStarted,
        userPickupStatus: BookingProgressStatus.notStarted,
        vendorDropOffStatus: BookingProgressStatus.notStarted,
        userDropOffStatus: BookingProgressStatus.notStarted,
        productUid: product.uid,
        userUid: firebaseAuth.currentUser!.uid,
        vendorUid: product.userUid!,
        bookedProduct: booking.bookedProduct?.copyWith(
          duration: duration['duration'],
          returnedEarly: false,
          isReviewed: false,
        ),
      );

      final data = booking.customToJson();

      //  create initial booking message
      final messageDocRef = messageCollection.doc();
      final message = MessageModel(
        message: booking.bookingNumber!,
        type: "booking",
        externalId: messageDocRef.id,
        sentAt: DateTime.now().toIso8601String(),
        bookingUid: docRef.id,
        senderUid: firebaseAuth.currentUser!.uid,
        receiverUid: product.userUid!,
        onGoing: true,
      );

      data['createdAt'] = DateTime.now().toIso8601String();
      data['updatedAt'] = DateTime.now().toIso8601String();

      transaction.set(bookingCollection.doc(docRef.id), data);

      transaction.update(productCollection.doc(product.uid),
          {'quantity': FieldValue.increment(booking.bookedProduct!.quantity!)});

      transaction.set(messageDocRef, message.toJson());
    });

    return docRef.id;
  }

  @override
  Future<bool> deleteProductPhoto(
      {required String productUid,
      required Map<String, dynamic> requestBody}) async {
    // await httpServiceRequester.deleteRequest(
    //   endpoint: ApiRoutes.deleteProductPhoto(productExternalId),
    //   requestBody: requestBody,
    // );

    return true;
  }

  @override
  Future<bool> addProductPhoto(
      {required String productUid,
      required Map<String, dynamic> requestBody}) async {
    // await httpServiceRequester.postFormDataRequest(
    //   endpoint: ApiRoutes.addProductPhoto(productExternalId),
    //   requestBody: FormData.fromMap(requestBody),
    // );

    return true;
  }

  @override
  Future<bool> deleteProduct({required String productUid}) async {
    // await httpServiceRequester.deleteRequest(
    //   endpoint: ApiRoutes.deleteProduct(productExternalId),
    // );

    return true;
  }

  @override
  Future<ProductModel> updateProduct(
      {required String productUid,
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
      {required String productUid,
      required Map<String, dynamic> requestBody}) async {
    // await httpServiceRequester.deleteRequest(
    //   endpoint: ApiRoutes.deleteProductPrice(productExternalId),
    //   requestBody: requestBody,
    // );

    return true;
  }

  @override
  Future<ProductHistoryModel> fetchVendorProducts(
      {required UserModel vendor,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    Query query = productCollection.where('userUid', isEqualTo: vendor.uid);
    // .orderBy('postedAt', descending: true);

    if (nextPage != null) {
      query =
          query.startAfterDocument(await productCollection.doc(nextPage).get());
    }

    final response =
        await query.limit(queryParam['pageSize'] ?? kProductPerPage).get();

    if (response.docs.isEmpty) {
      return ProductHistoryModel.fromJson({
        'data': null,
        'meta': null,
      });
    }

    return ProductHistoryModel.fromJson({
      'data': response.docs.map((e) {
        final data = (e.data() as Map<String, dynamic>);

        final jsonUser = vendor.toJson();
        data['user'] = jsonUser;
        return data;
      }).toList(),
      'meta': {
        'nextPage': response.docs.last.id,
      },
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
        .where('userUid', isEqualTo: firebaseAuth.currentUser!.uid)
        .count()
        .get();

    ZLoggerService.logOnDebug('fetchProductCount: ${response.count}');
    return response.count ?? 0;
  }
}
