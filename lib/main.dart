import 'dart:async';

import 'package:aider_mobile_app/core/auth/domain/models/statistics/statistic_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/wallet/wallet_model.dart';
import 'package:aider_mobile_app/core/domain/models/address/address_model.dart';
import 'package:aider_mobile_app/core/providers/auth_provider.dart';
import 'package:aider_mobile_app/core/services/git_it_service_locator.dart';
import 'package:aider_mobile_app/core/providers/location_provider.dart';
import 'package:aider_mobile_app/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:aider_mobile_app/src/features/kyc/domain/verification_model/verification_model.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/view_model/kyc_view_model.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/providers/rental_provider.dart';
import 'package:aider_mobile_app/src/features/review/presentation/view_models/review_view_model.dart';
import 'package:aider_mobile_app/src/features/search/presentation/providers/search_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/providers/wallet_provider.dart';
import 'core/routing/app_navigator.dart';
import 'core/routing/app_route.dart';
import 'core/services/crash_service.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/remote_config_service.dart';
import 'core/utils/app_theme_util.dart';
import 'core/providers/user_provider.dart';
import 'firebase_options.dart';
import 'src/features/explore/presentation/providers/explore_view_provider.dart';
import 'src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'src/features/transaction/presentation/providers/transaction_provider.dart';
import 'src/features/product/presentation/providers/product_provider.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(AddressModelAdapter());
    Hive.registerAdapter(StatisticModelAdapter());
    Hive.registerAdapter(WalletModelAdapter());
    Hive.registerAdapter(VerificationModelAdapter());

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    setUpGetItServiceLocator();
    await preLoaders();
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
                create: (context) => AuthProvider()),
            ChangeNotifierProvider<UserProvider>(
                create: (context) => UserProvider()),
            ChangeNotifierProvider<WalletProvider>(
                create: (context) => WalletProvider()),
            ChangeNotifierProvider<LocationProvider>(
                create: (context) => LocationProvider()),
            ChangeNotifierProvider<ProductProvider>(
                create: (context) => ProductProvider()),
            ChangeNotifierProvider<ExploreViewProvider>(
                create: (context) => ExploreViewProvider()),
            ChangeNotifierProvider<BottomNavViewModel>(
                create: (context) => BottomNavViewModel()),
            ChangeNotifierProvider<InboxViewModel>(
                create: (context) => InboxViewModel()),
            ChangeNotifierProvider<RentalProvider>(
                create: (context) => RentalProvider()),
            ChangeNotifierProvider<TransactionProvider>(
                create: (context) => TransactionProvider()),
            ChangeNotifierProvider<SearchProvider>(
                create: (context) => SearchProvider()),
            ChangeNotifierProvider<KycViewModel>(
                create: (context) => KycViewModel()),
            ChangeNotifierProvider<ReviewViewModel>(
                create: (context) => ReviewViewModel()),
            ChangeNotifierProvider<TransactionProvider>(
                create: (context) => TransactionProvider()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  },
      (error, stack) async =>
          await CrashService.recordCrashError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: (context, _) {
            var child = _!;
            child = DevicePreview.appBuilder(context, _);
            child =
                Toast(navigatorKey: AppNavigator.navigatorKey, child: child);
            return child;
          },
          theme: AppThemeUtil.lightTheme,
          initialRoute: AppRoute.splashScreen,
          onGenerateRoute: AppNavigator.generateRoute,
          navigatorKey: AppNavigator.navigatorKey,
        );
      },
    );
  }
}

Future<void> preLoaders() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
      PushNotificationService.firebaseMessagingBackgroundHandler);
  await sl.get<RemoteConfigService>().init();
  await sl.get<LocalNotificationService>().init();
  await CrashService.setCrashlyticsCollectionEnabled(
      RemoteConfigService.getRemoteData.configs['env']['production'] != 'true');
}
