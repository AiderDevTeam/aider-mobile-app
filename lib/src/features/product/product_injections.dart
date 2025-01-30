import 'package:get_it/get_it.dart';

import 'data/datasources/product_local_datasource.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository.dart';

void initProduct() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<ProductRemoteDatasource>(() =>
      ProductRemoteDatasourceImpl(firebaseFirestore: sl(), firebaseAuth: sl()));
  sl.registerLazySingleton<ProductLocalDatasource>(
      () => ProductLocalDatasourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        productRemoteDatasource: sl(),
        productLocalDatasource: sl(),
      ));
}
