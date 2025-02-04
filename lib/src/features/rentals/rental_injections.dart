import 'package:get_it/get_it.dart';

import 'data/datasources/rental_local_datasource.dart';
import 'data/datasources/rental_remote_datasource.dart';
import 'data/repositories/rental_repository.dart';

void initRental() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<RentalRemoteDataSource>(() =>
      RentalRemoteDataSourceImpl(
          firebaseFirestore: sl(),
          firebaseAuth: sl(),
          httpServiceRequester: sl()));
  sl.registerLazySingleton<RentalLocalDataSource>(
      () => RentalLocalDataSourceImpl(localStorageService: sl()));
  sl.registerLazySingleton<RentalRepository>(() => RentalRepositoryImpl(
        rentalRemoteDataSource: sl(),
        rentalLocalDataSource: sl(),
      ));
}
