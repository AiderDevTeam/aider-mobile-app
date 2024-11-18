
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';

import '../../../services/local_storage_service.dart';

abstract class UserLocalDatasource{
  Future<UserModel> retrieveUser();
  Future<void> persistUser(UserModel user);
  Future<bool> isLoggedIn();
}

class UserLocalDatasourceImpl extends UserLocalDatasource{
  UserLocalDatasourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;

  @override
  Future<UserModel> retrieveUser() async{
    Map<String, dynamic> authUserData = await localStorageService.decodeAndReadMap('userModel');
    ZLoggerService.logOnInfo('RETRIEVING USER');
    return UserModel.fromJson(authUserData);
  }

  @override
  Future<void> persistUser(UserModel user) async{
    await localStorageService.encodeAndWrite('userModel', user.toJson());
    ZLoggerService.logOnInfo('PERSISTING USER');
  }

  @override
  Future<bool> isLoggedIn() async => (await localStorageService.getToken()).isNotEmpty;
}