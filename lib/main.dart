import 'dart:async';

import 'package:aider_mobile_app/core/services/git_it_service_locator.dart';
import 'package:aider_mobile_app/core/view_models/location_view_model.dart';
import 'package:aider_mobile_app/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/view_model/kyc_view_model.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/view_model/rental_view_model.dart';
import 'package:aider_mobile_app/src/features/review/presentation/view_models/review_view_model.dart';
import 'package:aider_mobile_app/src/features/search/presentation/view_model/search_view_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/env/environment.dart';
import 'core/routing/app_navigator.dart';
import 'core/routing/app_route.dart';
import 'core/services/crash_service.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/remote_config_service.dart';
import 'core/utils/app_theme_util.dart';
import 'core/view_models/socket_view_model.dart';
import 'core/view_models/user_view_model.dart';
import 'firebase_options.dart';
import 'src/features/explore/presentation/view_models/explore_view_model.dart';
import 'src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'src/features/transaction/presentation/view_models/transaction_view_model.dart';
import 'src/features/product/presentation/view_models/product_view_model.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    setUpGetItServiceLocator();
    await preLoaders();
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel()),
            ChangeNotifierProvider<LocationViewModel>(create: (context) => LocationViewModel()),
            ChangeNotifierProvider<ProductViewModel>(create: (context) => ProductViewModel()),
            ChangeNotifierProvider<SocketViewModel>(create: (context) => SocketViewModel()),
            ChangeNotifierProvider<ExploreViewModel>(create: (context) => ExploreViewModel()),
            ChangeNotifierProvider<BottomNavViewModel>(create: (context) => BottomNavViewModel()),
            ChangeNotifierProvider<InboxViewModel>(create: (context) => InboxViewModel()),
            ChangeNotifierProvider<RentalViewModel>(create: (context) => RentalViewModel()),
            ChangeNotifierProvider<TransactionViewModel>(create: (context) => TransactionViewModel()),
            ChangeNotifierProvider<SearchViewModel>(create: (context) => SearchViewModel()),
            ChangeNotifierProvider<KycViewModel>(create: (context) => KycViewModel()),
            ChangeNotifierProvider<ReviewViewModel>(create: (context) => ReviewViewModel()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  }, (error, stack) async => await CrashService.recordCrashError(error, stack, fatal: true));
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
            child = Toast(navigatorKey: AppNavigator.navigatorKey, child: child);
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
  FirebaseMessaging.onBackgroundMessage(PushNotificationService.firebaseMessagingBackgroundHandler);
  await sl.get<RemoteConfigService>().init();
  await sl.get<LocalNotificationService>().init();
  await CrashService.setCrashlyticsCollectionEnabled(!Environment.inDevMode);
}
