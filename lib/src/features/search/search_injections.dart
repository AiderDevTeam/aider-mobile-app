import 'package:get_it/get_it.dart';

import 'data/datasources/search_local_datasource.dart';
import 'data/datasources/search_remote_datasource.dart';
import 'data/repositories/search_repository.dart';

void initSearch() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(firebaseFirestore: sl()));
  sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
        searchRemoteDataSource: sl(),
        searchLocalDataSource: sl(),
      ));
}
