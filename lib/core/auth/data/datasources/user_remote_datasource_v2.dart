import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user_types/user_type_model.dart';
import 'package:aider_mobile_app/core/errors/error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/cloudinary_service.dart';
import '../../../services/logger_service.dart';

abstract class UserRemoteDatasourceV2 {
  Future<UserModel> updateUser({required UserModel user});
  Future<void> setPushNotificationToken(
      {required String pushNotificationToken});
  Future<UserModel> fetchUserDetail();
  Stream<UserModel> fetchUserDetailStream();
  Future<UserModel> fetchUserDetailByUID({required String uid});
  Future<bool> verifyDisplayName({required String displayName});
  Future<bool> verifyEmail({required String email});
  Future<String> addProfileImage({required String imageUrl});
  Future<List<UserTypeModel>> fetchUserType();
}

class UserRemoteDatasourceV2Impl extends UserRemoteDatasourceV2 {
  UserRemoteDatasourceV2Impl({
    required this.firestore,
    required this.auth,
    required this.cloudinaryService,
  }) {
    usersCollection = firestore.collection('users');
    userTypesCollection = firestore.collection('userTypes');
  }

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final CloudinaryService cloudinaryService;
  late final CollectionReference usersCollection;
  late final CollectionReference userTypesCollection;
  @override
  Future<String> addProfileImage({required String imageUrl}) async {
    final profileImageUrl = await cloudinaryService.uploadImage(imageUrl, null);

    if (profileImageUrl == null) {
      throw const ServerException(message: 'Failed to upload image');
    }

    final user = auth.currentUser;

    await usersCollection.doc(user!.uid).update({
      'profilePhotoUrl': profileImageUrl,
    });

    return profileImageUrl;
  }

  @override
  Future<UserModel> fetchUserDetail() async {
    final token = await auth.currentUser!.getIdToken();
    ZLoggerService.logOnInfo("Fetch User Detail By UID: ${token}");
    final user = auth.currentUser;
    final result = await usersCollection.doc(user!.uid).get();

    if (result.exists) {
      return UserModel.fromJson(result.data() as Map<String, dynamic>);
    }

    throw const ServerException(message: 'User not found');
  }

  @override
  Future<UserModel> updateUser({required UserModel user}) async {
    final currentUser = auth.currentUser;

    final userJson = user.toJson();
    userJson
        .addAll({'addresses': user.addresses?.map((e) => e.toJson()).toList()});
    userJson.remove('password');
    // userJson.addAll({'joinedAt': FieldValue.serverTimestamp()});
    userJson.addAll({'updatedAt': FieldValue.serverTimestamp()});
    userJson.addAll({'itemsListed': user.itemsListed ?? 0});
    await usersCollection.doc(currentUser!.uid).set(userJson);
    return user;
  }

  @override
  Future<List<UserTypeModel>> fetchUserType() async {
    final result = await userTypesCollection.get();
    return result.docs
        .map((e) => UserTypeModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> verifyDisplayName({required String displayName}) async {
    final result = await usersCollection
        .where('displayName', isEqualTo: displayName)
        .get();
    return result.docs.isNotEmpty;
  }

  @override
  Future<bool> verifyEmail({required String email}) async {
    final result = await usersCollection.where('email', isEqualTo: email).get();
    return result.docs.isEmpty;
  }

  @override
  Stream<UserModel> fetchUserDetailStream() {
    final user = auth.currentUser;
    return usersCollection.doc(user!.uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }

  @override
  Future<UserModel> fetchUserDetailByUID({required String uid}) async {
    final result = await usersCollection.doc(uid).get();
    if (result.exists) {
      return UserModel.fromJson(result.data() as Map<String, dynamic>);
    }
    throw const ServerException(message: 'User not found');
  }

  @override
  Future<void> setPushNotificationToken(
      {required String pushNotificationToken}) async {
    final userUid = auth.currentUser!.uid;
    await userTypesCollection
        .doc(userUid)
        .update({'pushNotificationToken': pushNotificationToken});
  }
}
