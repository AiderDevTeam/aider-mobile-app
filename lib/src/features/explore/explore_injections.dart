
import 'package:get_it/get_it.dart';

import 'data/datasources/explore_local_datasource.dart';
import 'data/datasources/explore_remote_datasource.dart';
import 'data/repositories/explore_repository.dart';

void initExplore(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<ExploreRemoteDatasource>(() => ExploreRemoteDatasourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<ExploreLocalDatasource>(() => ExploreLocalDatasourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<ExploreRepository>(() => ExploreRepositoryImpl(
      exploreRemoteDatasource: sl(),
      exploreLocalDatasource: sl(),
  ));
}