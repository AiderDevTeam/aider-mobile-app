

import 'package:get_it/get_it.dart';

import 'data/datasources/review_local_datasource.dart';
import 'data/datasources/review_remote_datasource.dart';
import 'data/repositories/review_repository.dart';

void initReview(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<ReviewRemoteDataSource>(() => ReviewRemoteDataSourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<ReviewLocalDataSource>(() => ReviewLocalDataSourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(
      reviewRemoteDataSource: sl(),
      reviewLocalDataSource: sl()
  ));
}