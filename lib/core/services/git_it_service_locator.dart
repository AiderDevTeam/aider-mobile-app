
import 'package:aider_mobile_app/core/auth/auth_injections.dart';
import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import 'package:aider_mobile_app/core/services/location_service.dart';
import 'package:aider_mobile_app/src/features/product/product_injections.dart';
import 'package:aider_mobile_app/src/features/transaction/transaction_injections.dart';
import 'package:get_it/get_it.dart';
import '../../src/features/explore/explore_injections.dart';
import '../../src/features/inbox/inbox_injections.dart';
import '../../src/features/kyc/kyc_injections.dart';
import '../../src/features/rentals/rental_injections.dart';
import '../../src/features/review/review_injections.dart';
import '../../src/features/search/search_injections.dart';
import '../domain/respositories/location_repository.dart';
import 'local_notification_service.dart';
import 'local_storage_service.dart';
import 'push_notification_service.dart';
import 'remote_config_service.dart';


GetIt sl = GetIt.instance;

void setUpGetItServiceLocator(){
  // GeocodingService
  sl.registerSingleton<LocalStorageService>(LocalStorageService());
  sl.registerSingleton<LocalNotificationService>(LocalNotificationService());
  sl.registerLazySingleton<PushNotificationService>(() => PushNotificationService());
  sl.registerLazySingleton<RemoteConfigService>(() => RemoteConfigService());
  sl.registerLazySingleton(() => HttpServiceRequester());

  initAuth();

  initProduct();

  initRental();

  initExplore();

  initInbox();

  initTransaction();
  
  initSearch();

  initKyc();

  initReview();

  sl.registerLazySingleton(() => LocationService(httpServiceRequester: sl())); // Location
  sl.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(locationService: sl())); // Location


}