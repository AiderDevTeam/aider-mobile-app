import 'dart:collection';

import 'package:aider_mobile_app/core/auth/domain/models/user_types/user_type_model.dart';
import 'package:aider_mobile_app/core/domain/models/address/address_model.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../src/shared_widgets/modals/success_modal_content.dart';
import '../auth/data/repositories/user_repository_v2.dart';
import '../errors/failure.dart';
import '../routing/app_route.dart';
import '../services/git_it_service_locator.dart';
import '../services/logger_service.dart';
import '../services/push_notification_service.dart';
import '../utils/app_dialog_util.dart';
import '../utils/helper_util.dart';
import '../../src/shared_widgets/modals/error_modal_content.dart';
import '../auth/domain/models/user/user_model.dart';
import 'location_provider.dart';

class UserProvider extends BaseProvider {
  final _userRepository = sl.get<UserRepositoryV2>();

  UserModel _user = const UserModel();

  List<UserTypeModel> _userTypes = [];

  set setUserTypes(List<UserTypeModel> data) {
    _userTypes = data;
    notifyListeners();
  }

  UnmodifiableListView<UserTypeModel> get getUserTypes =>
      UnmodifiableListView(_userTypes);

  set setUser(UserModel user) {
    _user = user;
    notifyListeners();
    // _persistUser();
  }

  UserModel get getUser => _user;

  Future<AddressModel?> getAddress(BuildContext context,
      {required Map<String, dynamic>? requestBody}) async {
    if (requestBody == null) return null;

    if (context.mounted &&
        (requestBody['placeId'] != null &&
            requestBody['placeId'].toString().isNotEmpty)) {
      final locationDetails = await context
          .read<LocationProvider>()
          .fetchLocationDetails(requestBody['placeId']);

      final locality = HelperUtil.getLocalityFromAddressComponents(
          locationDetails?.addressComponents ?? []);

      final address = {
        "latitude": locationDetails?.geometry?['location']['lat'] ?? 0,
        "longitude": locationDetails?.geometry?['location']['lng'] ?? 0,
        "country": "Nigeria",
        "countryCode": 'NG',
        "originName": requestBody['originName'],
        "city":
            locality.first.isEmpty ? requestBody['originName'] : locality.first
      };

      return AddressModel.fromJson(address);
    }
    return null;
  }

  Future<void> createUser(BuildContext context,
      {required UserModel user, required Map<String, dynamic> location}) async {
    final token = await sl.get<PushNotificationService>().getFcmToken();

    user = user.copyWith(pushNotificationToken: token);

    final address = await getAddress(context, requestBody: location);

    if (address != null) {
      user = user.copyWith(addresses: [address]);
    }

    final result = await _userRepository.updateUser(user: user);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      _user = right;
      notifyListeners();

      AppNavigator.pushNamedAndRemoveUntil(
          context, AppRoute.homeScreen, (p0) => false);
    });
  }

  Future<void> updateUser(BuildContext context,
      {required UserModel user,
      required Map<String, dynamic>? location}) async {
    AppDialogUtil.loadingDialog(context);

    final address = await getAddress(context, requestBody: location);

    if (address != null) {
      user = user.copyWith(addresses: [address]);
    }

    final result = await _userRepository.updateUser(user: user);

    if (context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      if (user.canReceiveEmailUpdates != null && user.canReceiveEmailUpdates! ||
          user.canReceivePushNotifications != null &&
              user.canReceivePushNotifications! ||
          user.canReceiveSMS != null && user.canReceiveSMS!) {
        _user = right;
        notifyListeners();
        // _persistUser();
        return;
      }

      AppDialogUtil.popUpModal(
        context,
        modalContent: const SuccessModalContent(
          title: 'Updated',
          message: 'User profile updated',
        ),
      );
      _user = right;
      notifyListeners();
      // _persistUser();
    });
  }

  String _displayNameAvailable = '';
  String get displayNameAvailableStatus => _displayNameAvailable;
  void setDisplayNameAvailable(String value, [bool notify = false]) {
    _displayNameAvailable = value;
    if (notify) notifyListeners();
  }

  Future<void> addProfilePhoto(BuildContext context,
      {required String imageUrl}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.addProfileImage(imageUrl: imageUrl);

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      setUser = _user.copyWith(profilePhotoUrl: right);
      notifyListeners();
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Profile Image uploaded',
          message: '',
          onButtonPressed: () {
            AppNavigator.pop(context);
          },
        ),
      );
    });
  }

  Future<void> verifyDisplayName(BuildContext context,
      {required String displayName}) async {
    setDisplayNameAvailable('');
    setLoading(true, component: 'verifyDisplayName');
    final result =
        await _userRepository.verifyDisplayName(displayName: displayName);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setDisplayNameAvailable(FailureToMessage.mapFailureToMessage(left));
        setLoading(false, component: 'verifyDisplayName');
      });
    }, (right) {
      setDisplayNameAvailable('available');
      setLoading(false, component: 'verifyDisplayName');
    });
  }

  String _emailAvailable = '';
  String get emailAvailableStatus => _emailAvailable;
  void setEmailAvailable(String value, [bool notify = false]) {
    _emailAvailable = value;
    if (notify) notifyListeners();
  }

  Future<void> verifyEmail(BuildContext context,
      {required String email}) async {
    setEmailAvailable('');
    setLoading(true, component: 'verifyEmail');
    final result = await _userRepository.verifyEmail(email: email);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setEmailAvailable(FailureToMessage.mapFailureToMessage(left));
        setLoading(false, component: 'verifyEmail');
      });
    }, (right) {
      ZLoggerService.logOnInfo("Email available: $right");
      if (!right) {
        setEmailAvailable('this email is already in use');
      } else {
        setEmailAvailable('available');
      }
      setLoading(false, component: 'verifyEmail');
    });
  }

  Future<void> signUpOTP(BuildContext context,
      {required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    // final result = await _userRepository.signUpOTP(requestBody: requestBody);

    if (context.mounted) AppNavigator.pop(context);

    // result.fold((left) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     AppDialogUtil.popUpModal(
    //       context,
    //       modalContent: ErrorModalContent(
    //         errorMessage: FailureToMessage.mapFailureToMessage(left),
    //       ),
    //     );
    //   });
    // }, (right) {
    AppNavigator.pushNamed(context, AppRoute.otpVerificationScreen,
        arguments: "0000");
    // });
  }

  // /// SAVING TO BANK WALLET
  // UnmodifiableListView<WalletModel> get getWallets =>
  //     UnmodifiableListView(_user.wallets ?? []);
  // WalletModel? get getDefaultWallet =>
  //     (_user.wallets ?? []).firstWhere((obj) => obj.isDefault == true,
  //         orElse: () => const WalletModel());

  // Future<void> fetchWalletData() async {
  //   final result = await _userRepository.fetchWallet();
  //   // ZLoggerService.logOnInfo("Wallet data fetched and updated successfully. $result");
  //   result.fold(
  //     (failure) {
  //       ZLoggerService.logOnError("Failed to fetch wallet data: $failure");
  //     },
  //     (wallet) {
  //       setUser = _user.copyWith(
  //         wallets: wallet,
  //       );
  //       ZLoggerService.logOnInfo(
  //           "Wallet data fetched and updated successfully.");
  //     },
  //   );
  // }

  // Future<void> saveWallet(BuildContext context,
  //     {required Map<String, dynamic> requestBody}) async {
  //   AppDialogUtil.loadingDialog(context);

  //   final result = await _userRepository.saveWallet(requestBody: requestBody);

  //   if (context.mounted) AppNavigator.pop(context);

  //   result.fold((left) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       AppDialogUtil.popUpModal(
  //         context,
  //         modalContent: ErrorModalContent(
  //           errorMessage: FailureToMessage.mapFailureToMessage(left),
  //         ),
  //       );
  //     });
  //   }, (bank) {
  //     setUser = _user.copyWith(
  //       wallets: List.from(_user.wallets ?? [])..add(bank),
  //     );
  //     AppDialogUtil.popUpModal(
  //       context,
  //       modalContent: SuccessModalContent(
  //         title: 'Bank Account',
  //         message: 'Bank account added to wallet.',
  //         onButtonPressed: () {
  //           AppNavigator.of(context)
  //             ..pop()
  //             ..pop();
  //         },
  //       ),
  //     );
  //   });
  // }

  // /// UPDATE WALLET DEFAULT
  // Future<void> setWalletToDefault(BuildContext context,
  //     {String? walletExternalId}) async {
  //   AppDialogUtil.loadingDialog(context);

  //   final result = await _userRepository.setWalletToDefault(
  //       walletExternalId: walletExternalId);

  //   if (context.mounted) AppNavigator.pop(context);

  //   result.fold((left) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       AppDialogUtil.popUpModal(
  //         context,
  //         modalContent: ErrorModalContent(
  //           errorMessage: FailureToMessage.mapFailureToMessage(left),
  //         ),
  //       );
  //     });
  //   }, (wallet) {
  //     List<WalletModel> wallets = List.from(_user.wallets ?? []);

  //     final index =
  //         wallets.indexWhere((obj) => obj.externalId == walletExternalId);
  //     if (index >= 0) {
  //       wallets[index] = wallet;
  //       setUser = _user.copyWith(
  //         wallets: wallets,
  //       );
  //     }
  //     AppDialogUtil.popUpModal(
  //       context,
  //       modalContent: SuccessModalContent(
  //         title: 'Bank Updated',
  //         message: 'Bank account updated.',
  //         onButtonPressed: () {
  //           AppNavigator.of(context).pop();
  //         },
  //       ),
  //     );
  //   });
  // }

  /// USER TYPE
  Future<void> fetchUserType(BuildContext context) async {
    setComponentErrorType = null;
    setLoading(true, component: 'userTypes');

    final result = await _userRepository.fetchUserType();

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'userTypes'
      };
      setLoading(false, component: 'userTypes');
    }, (right) {
      if (right.isEmpty) {
        setComponentErrorType = {
          'error': 'No user type found',
          'component': 'userTypes'
        };
        setLoading(false, component: 'userTypes');
        return;
      }
      setUserTypes = right;
    });
  }

  Future<void> retrieveUser() async {
    ZLoggerService.logOnInfo('Fetching user detail');
    final result = await _userRepository.fetchUserDetail();
    result.fold((l) {
      ZLoggerService.logOnError('Failed to fetch user detail');
    }, (user) {
      ZLoggerService.logOnInfo('User detail fetched: $user');
      setUser = user;
    });
  }

  // Future<void> _persistUser() async {
  //   final result = await _userRepository.persistUser(_user);
  //   result.fold((l) => null, (user) => null);
  // }

  initState() async {
    await retrieveUser();
  }
}
