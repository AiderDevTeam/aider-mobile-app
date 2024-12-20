
import 'package:get_it/get_it.dart';

import 'data/datasources/transaction_local_datasource.dart';
import 'data/datasources/transaction_remote_datasource.dart';
import 'data/repositories/transaction_repository.dart';

void initTransaction(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<TransactionRemoteDatasource>(() => TransactionRemoteDatasourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<TransactionLocalDatasource>(() => TransactionLocalDatasourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<TransactionRepository>(() => TransactionRepositoryImpl(
      transactionRemoteDatasource: sl(),
      transactionLocalDatasource: sl(),
  ));
}