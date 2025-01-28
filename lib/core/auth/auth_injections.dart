import 'package:aider_mobile_app/core/auth/data/datasources/auth_remote_datasource.dart';
import 'package:aider_mobile_app/core/auth/data/datasources/wallet_remote_datasource.dart';
import 'package:aider_mobile_app/core/auth/data/repositories/wallet_repository.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/user_local_datasource.dart';
import 'data/datasources/user_remote_datasource_v2.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/user_repository_v2.dart';

void initAuth() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<UserLocalDatasource>(
      () => UserLocalDatasourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(firebaseAuth: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDatasource: sl()));
  sl.registerLazySingleton<UserRemoteDatasourceV2>(() =>
      UserRemoteDatasourceV2Impl(
          firestore: sl(), auth: sl(), cloudinaryService: sl()));
  sl.registerLazySingleton<UserRepositoryV2>(
      () => UserRepositoryV2Impl(userRemoteDatasourceV2: sl()));

  sl.registerLazySingleton<WalletRemoteDatasource>(() =>
      WalletRemoteDatasourceImpl(firebaseFirestore: sl(), firebaseAuth: sl()));
  sl.registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(walletRemoteDatasource: sl()));
}
