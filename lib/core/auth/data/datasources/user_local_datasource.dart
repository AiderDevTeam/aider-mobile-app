import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:hive/hive.dart';

abstract class UserLocalDatasource {
  Future<UserModel?> retrieveUserByUid(String uid);
  Future<void> persistUser(UserModel user);
  Future<void> dispose();
}

class UserLocalDatasourceImpl extends UserLocalDatasource {
  Box<UserModel>? _userBox;
  static const String _boxName = 'userModel';

  UserLocalDatasourceImpl();

  Future<Box<UserModel>> get _box async {
    if (_userBox == null || !_userBox!.isOpen) {
      _userBox = await Hive.openBox<UserModel>(_boxName);
    }
    return _userBox!;
  }

  @override
  Future<UserModel?> retrieveUserByUid(String uid) async {
    final box = await _box;
    return box.get(uid);
  }

  @override
  Future<void> persistUser(UserModel user) async {
    final box = await _box;
    await box.put(user.uid, user);
  }

  @override
  Future<void> dispose() async {
    if (_userBox != null && _userBox!.isOpen) {
      await _userBox!.close();
      _userBox = null;
    }
  }
}
