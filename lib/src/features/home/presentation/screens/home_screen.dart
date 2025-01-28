import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/providers/user_provider.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/screens/explore_screen.dart';
import 'package:aider_mobile_app/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/screens/rentals_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/local_notification_service.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/push_notification_service.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../inbox/presentation/screens/inbox_screen.dart';
import '../../../product/presentation/view_models/product_view_model.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<void> fetchUserWallet([int page = 1]) async {
  //   if (!mounted) return;
  //   await context.read<UserViewProvider>().fetchWalletData();
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userViewModel = context.read<UserProvider>();

      // Fetch wallet data and set default wallet if available
      // await fetchUserWallet();
      _fcmInitialization();
      _requestForNotificationPermissions();
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _widgetOptions = const <Widget>[
    ExploreScreen(),
    RentalsScreen(),
    SizedBox(),
    InboxScreen(),
    ProfileScreen(),
  ];

  void onTap(int index) async {
    final bottomNavProvider = context.read<BottomNavViewModel>();
    final user = context.read<UserProvider>().getUser;
    if (index == 2) {
      // if(user.userIdentifications?.first.status == kRejected){
      //   AppNavigator.pushNamed(
      //     context, AppRoute.afterVerificationScreen,
      //     arguments: {
      //       'kycType': user.userIdentifications?.first.type,
      //       // 'fromProfile': false
      //     },
      //   );
      //   return;
      // }

      // if(user.idVerificationStatus != kCompletedStatus){
      //   AppNavigator.pushNamed(context, AppRoute.verifyIdentityScreen);
      //   return;
      // }

      if (user.wallets?.length == 0) {
        AppNavigator.pushNamed(context, AppRoute.paymentScreen);
        return;
      }

      // if(user.idVerificationStatus == kCompletedStatus){
      //   context.read<ProductViewModel>().clearProductDescription();
      //   AppNavigator.pushNamed(context, AppRoute.listProductScreen);
      //   return;
      // }

      context.read<ProductViewModel>().clearProductDescription();
      AppNavigator.pushNamed(context, AppRoute.listProductScreen);
      return;
    }

    // if(index == 3){
    //   if(user.idVerificationStatus != kCompletedStatus){
    //     AppNavigator.pushNamed(context, AppRoute.verifyIdentityScreen);
    //     return;
    //   }
    // }

    bottomNavProvider.selectNavTab = index;
  }

  void _fcmInitialization() async {
    if (mounted)
      await sl.get<PushNotificationService>().setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BaseView<BottomNavViewModel>(
            builder: (context, bottomNavProvider, child) =>
                _widgetOptions.elementAt(bottomNavProvider.getSelectedNavTab)),
      ),
      bottomNavigationBar: BaseView<BottomNavViewModel>(
        builder: (context, bottomNavProvider, child) => HomeBottomNavigationBar(
          currentIndex: bottomNavProvider.getSelectedNavTab,
          onTap: onTap,
        ),
      ),
    );
  }

  void _requestForNotificationPermissions() async {
    await Future.delayed(const Duration(seconds: 3));
    LocalNotificationService().requestNotificationPermissions();
  }
}
