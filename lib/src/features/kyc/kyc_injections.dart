import 'package:get_it/get_it.dart';

import 'data/datasources/kyc_remote_datasource.dart';
import 'data/repositories/kyc_repository.dart';

void initKyc(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<KycRemoteDataSource>(() => KycRemoteDataSourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<KycRepository>(() => KycRepositoryImpl(
    kycRemoteDataSource: sl(),
    // kycLocalDatasource: sl(),
  ));
}