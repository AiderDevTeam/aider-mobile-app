
import 'package:get_it/get_it.dart';

import 'data/datasources/inbox_local_datasource.dart';
import 'data/datasources/inbox_remote_datasource.dart';
import 'data/repositories/inbox_repository.dart';

void initInbox(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<InboxRemoteDatasource>(() => InboxRemoteDatasourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<InboxLocalDatasource>(() => InboxLocalDatasourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<InboxRepository>(() => InboxRepositoryImpl(
      inboxRemoteDatasource: sl(),
      inboxLocalDatasource: sl(),
  ));
}