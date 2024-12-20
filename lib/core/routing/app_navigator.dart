import 'package:aider_mobile_app/src/features/auth/forgot_password/presentation/screens/forgot_password_success_screen.dart';
import 'package:aider_mobile_app/src/features/auth/login/presentation/screens/reset_password_screen.dart';
import 'package:aider_mobile_app/src/features/auth/sign_up/presentation/screens/user_type_screen.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/screens/see_all_rental_listing_screen.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/screens/see_all_categories_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/bvn_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/bvn_selfie_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/drivers_selfie_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/drivers_verification_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/nin_selfie_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/passport_screen_one.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/user_identification_screen.dart';
import 'package:aider_mobile_app/src/features/kyc/presentation/screens/verify_identity.dart';
import 'package:aider_mobile_app/src/features/product/presentation/screens/edit_listed_product_screen.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/screens/change_password_screen.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/screens/notification_screen.dart';
import 'package:aider_mobile_app/src/features/review/presentation/screens/reviews_screen.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/screens/support_screen.dart';
import 'package:flutter/material.dart';
import '../../src/features/home/presentation/screens/home_screen.dart';
import '../../src/features/inbox/presentation/screens/chat_screen.dart';
import '../../src/features/kyc/presentation/screens/after_verification_screen.dart';
import '../../src/features/kyc/presentation/screens/nin_details_screen_one.dart';
import '../../src/features/kyc/presentation/screens/nin_details_screen_two.dart';
import '../../src/features/kyc/presentation/screens/passport_selfie_screen.dart';
import '../../src/features/product/domain/models/product/product_model.dart';
import '../../src/features/product/presentation/screens/list_product_screen.dart';
import '../../src/features/product/presentation/screens/listed_products_screen.dart';
import '../../src/features/product/presentation/screens/product_description_screen.dart';
import '../../src/features/product/presentation/screens/product_detail_screen.dart';
import '../../src/features/profile/presentation/screens/account_settings_screen.dart';
import '../../src/features/profile/presentation/screens/edit_profile_screen.dart';
import '../../src/features/profile/presentation/screens/payment_screen.dart';
import '../../src/features/search/presentation/screens/search_screen.dart';
import '../../src/features/profile/presentation/screens/vendor_profile_screen.dart';
import '../auth/domain/models/user/user_model.dart';
import '../constants/colors.dart';
import '../../src/features/auth/sign_up/presentation/screens/additional_detail_screen.dart';
import '../../src/features/auth/sign_up/presentation/screens/otp_verification_screen.dart';
import '../../src/features/auth/sign_up/presentation/screens/personal_detail_screen.dart';
import '../../src/features/auth/sign_up/presentation/screens/phone_number_screen.dart';
import '../../src/features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../src/features/onboarding/presentation/screens/splash_screen.dart';
import 'app_route.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case AppRoute.onboardingScreen:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());

      case AppRoute.phoneNumberScreen:
        return MaterialPageRoute(builder: (context) => const PhoneNumberScreen());

      case AppRoute.otpVerificationScreen:
        return MaterialPageRoute(builder: (context) => OtpVerificationScreen(otpCode: args as String?,));

      case AppRoute.personalDetailScreen:
        return MaterialPageRoute(builder: (context) => const PersonalDetailScreen());

      case AppRoute.additionalDetailScreen:
        return MaterialPageRoute(builder: (context) => const AdditionalDetailScreen());

      case AppRoute.userTypeScreen:
        return MaterialPageRoute(builder: (context) => const UserTypeScreen());

      case AppRoute.forgotPasswordSuccessScreen:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordSuccessScreen());

      case AppRoute.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AppRoute.seeAllCategoriesScreen:
        return MaterialPageRoute(builder: (context) => SeeAllCategoriesScreen(param: args as Map<String, dynamic>));

      case AppRoute.listProductScreen:
        return MaterialPageRoute(builder: (context) => const ListProductScreen());

      case AppRoute.accountSettingsScreen:
        return MaterialPageRoute(builder: (context) => const AccountSettingsScreen());

      case AppRoute.seeAllRentalListeningScreen:
        return MaterialPageRoute(builder: (context) => SeeAllRentalListeningScreen(param: args as Map<String, dynamic>));

        case AppRoute.productDescriptionScreen:
        return MaterialPageRoute(builder: (context) => const ProductDescriptionScreen());

      case AppRoute.listedProductsScreen:
        return MaterialPageRoute(builder: (context) => ListedProductsScreen(navigateFromListing: args as bool,));

      case AppRoute.changePassword:
        return MaterialPageRoute(builder: (context) => const ChangePasswordScreen());

      case AppRoute.editProfile:
        return MaterialPageRoute(builder: (context) => const EditUserProfile());

      case AppRoute.notificationScreen:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());

      case AppRoute.supportScreen:
        return MaterialPageRoute(builder: (context) => const SupportScreen());

      case AppRoute.productDetailScreen:
        return MaterialPageRoute(builder: (context) => ProductDetailScreen(product: args as ProductModel,));

      case AppRoute.editListedProductScreen:
        return MaterialPageRoute(builder: (context) => EditListedProductScreen(product: args as ProductModel,));

      case AppRoute.chatScreen:
        return MaterialPageRoute(builder: (context) => ChatScreen(param: args as Map<String, dynamic>));

      case AppRoute.search:
        return PageRouteBuilder(
            settings: settings,
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (_, __, ___) => const SearchScreen(),
            transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child)
        );
        
      case AppRoute.vendorProfileScreen:
        return MaterialPageRoute(builder: (context) => VendorProfileScreen(user: args as UserModel));

      case AppRoute.paymentScreen:
        return MaterialPageRoute(builder: (context) => const PaymentScreen());

      case AppRoute.bvnVerificationScreen:
        return MaterialPageRoute(builder: (context) => const BvnScreen());

      case AppRoute.bvnSelfieScreen:
        return MaterialPageRoute(builder: (context) => const BvnSelfieScreen());

      case AppRoute.driversVerificationScreen:
        return MaterialPageRoute(builder: (context) => const DriversLicenseVerificationScreen());

      case AppRoute.driversSelfieScreen:
        return MaterialPageRoute(builder: (context) => const DriversSelfieScreen());

      case AppRoute.verifyIdentityScreen:
        return MaterialPageRoute(builder: (context) => const VerifyIdentity());

      case AppRoute.ninVerificationScreenOne:
        return MaterialPageRoute(builder: (context) => const NiNDetailsScreenOne());

      case AppRoute.ninVerificationScreenTwo:
        return MaterialPageRoute(builder: (context) => const NiNDetailsScreenTwo());

      case AppRoute.userIdentityScreen:
        return MaterialPageRoute(builder: (context) => const UserIdentificationScreen());

      case AppRoute.passportScreen:
        return MaterialPageRoute(builder: (context) => const PassportScreenOne());

      case AppRoute.reviewScreen:
        return MaterialPageRoute(builder: (context) => const ReviewsScreen());

      case AppRoute.passportSelfie:
        return MaterialPageRoute(builder: (context) => const PassportSelfieScreen());

      case AppRoute.ninSelfieScreen:
        return MaterialPageRoute(builder: (context) => const NinSelfieScreen());

      case AppRoute.afterVerificationScreen:
        return MaterialPageRoute(builder: (context) => AfterVerification(param: args as Map<String, dynamic>));

      case AppRoute.resetPasswordScreen:
        return MaterialPageRoute(builder: (context) => const ResetPasswordScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        backgroundColor: kPrimaryWhite,
        body: Center(
          child: Text('Page Not Found!', style: TextStyle(fontSize: 16)),
        ),
      );
    });
  }

  static Future<Object?> pushNamed(BuildContext context, String routeName,
          {Object? arguments}) =>
      Navigator.pushNamed(context, routeName, arguments: arguments);

  static Future<Object?> pushReplacementNamed(
          BuildContext context, String routeName,
          {Object? arguments, Object? result}) =>
      Navigator.pushReplacementNamed(context, routeName,
          arguments: arguments, result: result);

  static Future<Object?> pushNamedAndRemoveUntil(
    BuildContext context,
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
        predicate,
        arguments: arguments,
      );

  static void pop(BuildContext context, [Object? result]) =>
      Navigator.pop(context, result);

  static NavigatorState of(BuildContext context, {bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator);

  static Future<Object?> popAndPushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
    Object? result,
  }) =>
      Navigator.popAndPushNamed(
        context,
        routeName,
        arguments: arguments,
        result: result,
      );
}
