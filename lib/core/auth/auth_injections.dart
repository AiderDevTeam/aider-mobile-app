


import 'package:get_it/get_it.dart';

import 'data/datasources/user_local_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/repositories/user_repository.dart';

void initAuth(){
  final sl = GetIt.instance;
    sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasourceImpl(httpServiceRequester: sl()));
    sl.registerLazySingleton<UserLocalDatasource>(() => UserLocalDatasourceImpl(localStorageService: sl()));
    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userRemoteDatasource: sl(), userLocalDatasource: sl()));

}