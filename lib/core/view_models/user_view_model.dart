import 'dart:collection';

import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/view_models/base_view_model.dart';
import 'package:aider_mobile_app/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../src/shared_widgets/modals/success_modal_content.dart';
import '../auth/data/repositories/user_repository.dart';
import '../auth/domain/models/wallet/wallet_model.dart';
import '../errors/failure.dart';
import '../routing/app_route.dart';
import '../services/git_it_service_locator.dart';
import '../services/logger_service.dart';
import '../services/push_notification_service.dart';
import '../services/socket_service.dart';
import '../utils/app_dialog_util.dart';
import '../utils/helper_util.dart';
import '../../src/shared_widgets/modals/error_modal_content.dart';
import '../auth/domain/models/user/user_model.dart';
import '../utils/media_file_util.dart';
import 'location_view_model.dart';

class UserViewModel extends BaseViewModel{
  final _userRepository = sl.get<UserRepository>();
  Map<String, dynamic> _signupRequestBody = {};
  Map<String, dynamic> _otpData = {};
  static String _resendOtpCode = '';

  UserModel _user = const UserModel();

  List<dynamic> _userTypes = [];

  set setUserTypes(List<dynamic> data){
    _userTypes = data;
    notifyListeners();
  }

  UnmodifiableListView get getUserTypes => UnmodifiableListView(_userTypes);

  set setUser(UserModel user){
    _user = user;
    notifyListeners();
    _persistUser();
  }
  

  void userOnSocket(){
    SocketService().once('fetchUser', (data){
      ZLoggerService.logOnInfo('FETCHING USER \n $data');
      if(data != null){
        setUser = UserModel.fromJson(data);
      }
    });
    SocketService().off('fetchUser');
  }

  UserModel get getUser => _user;

  void setOTPData(Map<String, dynamic> data){
    _otpData = data;
  }
  UnmodifiableMapView<String, dynamic> get getOTPData => UnmodifiableMapView(_otpData);

  set setResendOtpCode(String code){
    _resendOtpCode = code;
  }

  String get getResendOtpCode => _resendOtpCode;

  void setSignupRequestBody(Map<String, dynamic> request){
    _signupRequestBody = {..._signupRequestBody, ...request};
  }

  UnmodifiableMapView<String, dynamic> get getSignupRequestBody => UnmodifiableMapView(_signupRequestBody);

  Future<void> authentication(BuildContext context, {String type = 'login', required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    final token = await sl.get<PushNotificationService>().getFcmToken();
    requestBody['pushNotificationToken'] = token;

    if(type != 'login'){
      if(context.mounted && (requestBody['placeId'] != null && requestBody['placeId'].toString().isNotEmpty)){
        final locationDetails = await context.read<LocationViewModel>().fetchLocationDetails(requestBody['placeId']);
        final locality = HelperUtil.getLocalityFromAddressComponents(locationDetails?.addressComponents?? []);
        final address = {
          "latitude": locationDetails?.geometry?['location']['lat']?? 0,
          "longitude": locationDetails?.geometry?['location']['lng']?? 0,
          "country": "Nigeria",
          "countryCode": 'NG',
          "originName": requestBody['originName'],
          "city": locality.first.isEmpty ? requestBody['originName'] : locality.first
        };
        requestBody["address"] = address;
      }
    }
    final result = type == 'login'?
    await _userRepository.login(requestBody: requestBody)
        :
    await _userRepository.signup(requestBody: requestBody);
    if(context.mounted) {AppNavigator.pop(context);}

    result.fold((failure){
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (user){
      context.read<BottomNavViewModel>().selectNavTab = 0;
      setUser = user;
      AppNavigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (p0) => false);
    });
  }

  Future<void> forgotPassword(BuildContext context, {bool isResend = false, required Map<String, dynamic> requestBody}) async{
    if(!isResend) AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.forgotPassword(requestBody: requestBody);

    if(context.mounted && !isResend) {AppNavigator.pop(context);}

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (right) {
      setResendOtpCode = right;
      if(isResend) return;
      AppNavigator.pushNamed(context, AppRoute.otpVerificationScreen, arguments: right);
    });
  }

  Future<void> resetPassword(BuildContext context, {bool inApp = false, required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.resetPassword(requestBody: requestBody);

    if(context.mounted) {AppNavigator.pop(context);}

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (right) {
      if(right){
        AppDialogUtil.popUpModal(
          context,
          modalContent: SuccessModalContent(
            title: 'Reset Password',
            message: inApp? 'Your password is reset':'Your password is reset.\nYou can login now',
            onButtonPressed: (){
              if(inApp){
                AppNavigator.pop(context);
                AppNavigator.pop(context);
                return;
              }
              AppNavigator.pushNamedAndRemoveUntil(context, AppRoute.onboardingScreen, (p0) => false);
            },
          ),
        );
      }
    });
  }

  Future<void> deleteAccount(BuildContext context, {required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.deleteAccount(requestBody: requestBody);

    if(context.mounted) {AppNavigator.pop(context);}

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Account deleted',
          message: '',
          onButtonPressed: (){
            HelperUtil.logOut();
          },
        ),
      );
    });
  }

  Future<void> updateUser(BuildContext context, { required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    if(context.mounted && (requestBody['placeId'] != null && requestBody['placeId'].toString().isNotEmpty)){
      final locationDetails = await context.read<LocationViewModel>().fetchLocationDetails(requestBody['placeId']);
      final locality = HelperUtil.getLocalityFromAddressComponents(locationDetails?.addressComponents?? []);
      final address = {
        "latitude": locationDetails?.geometry?['location']['lat']?? 0,
        "longitude": locationDetails?.geometry?['location']['lng']?? 0,
        "country": "Nigeria",
        "countryCode": 'NG',
        "originName": requestBody['originName'],
        "city": locality.first.isEmpty ? requestBody['originName'] : locality.first
      };
      requestBody["address"] = address;
    }

    final result = await _userRepository.updateUser(requestBody: requestBody);

    if(context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (right) {
      if (requestBody.containsKey('canReceiveEmailUpdates') ||
          requestBody.containsKey('canReceivePushNotifications') ||
          requestBody.containsKey('canReceiveSms')) {
        _user = right;
        notifyListeners();
        _persistUser();
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
      _persistUser();
    });
  }

  String _displayNameAvailable = '';
  String get displayNameAvailableStatus => _displayNameAvailable;
  void setDisplayNameAvailable(String value, [bool notify = false]){
    _displayNameAvailable = value;
    if(notify) notifyListeners();
  }

  Future<void> addProfilePhoto (BuildContext context, {required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    final imagePath = await MediaFileUtil.getMultipartFile(requestBody['profilePhoto']);
    requestBody['profilePhoto'] = imagePath;

    final result = await _userRepository.addProfileImage(requestBody: requestBody);

    if(context.mounted) {AppNavigator.pop(context);}

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Profile Image uploaded',
          message: '',
          onButtonPressed: (){
            AppNavigator.pop(context);
          },
        ),
      );
    });
  }

  Future<void> verifyDisplayName(BuildContext context, {required Map<String, dynamic> requestBody}) async{
    setDisplayNameAvailable('');
    setLoading(true, component: 'verifyDisplayName');
    final result = await _userRepository.verifyDisplayName(requestBody: requestBody);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
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
  void setEmailAvailable(String value, [bool notify = false]){
    _emailAvailable = value;
    if(notify) notifyListeners();
  }
  Future<void> verifyEmail(BuildContext context, {required Map<String, dynamic> requestBody}) async{
    setEmailAvailable('');
    setLoading(true, component: 'verifyEmail');
    final result = await _userRepository.verifyEmail(requestBody: requestBody);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        setEmailAvailable(FailureToMessage.mapFailureToMessage(left));
        setLoading(false, component: 'verifyEmail');
      });

    }, (right) {
      setEmailAvailable('available');
      setLoading(false, component: 'verifyEmail');
    });
  }

  Future<void> signUpOTP(BuildContext context, { required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.signUpOTP(requestBody: requestBody);

    if(context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (right) {
      AppNavigator.pushNamed(context, AppRoute.otpVerificationScreen, arguments: right);
    });
  }

  /// SAVING TO BANK WALLET
  UnmodifiableListView<WalletModel> get getWallets => UnmodifiableListView(_user.wallets?? []);
  WalletModel? get getDefaultWallet => (_user.wallets?? []).firstWhere((obj) => obj.isDefault == true, orElse: ()=> const WalletModel());

  Future<void> saveWallet(BuildContext context, { required Map<String, dynamic> requestBody}) async{
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.saveWallet(requestBody: requestBody);

    if(context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (bank) {
      setUser = _user.copyWith(
        wallets: List.from(_user.wallets?? [])..add(bank),
      );
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Bank Account',
          message: 'Bank account added to wallet.',
          onButtonPressed: (){
            AppNavigator.of(context)..pop()..pop();
          },
        ),
      );
    });
  }

  /// UPDATE WALLET DEFAULT
  Future<void> setWalletToDefault(BuildContext context, {String? walletExternalId}) async{
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.setWalletToDefault(walletExternalId: walletExternalId);

    if(context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });

    }, (wallet) {
      List<WalletModel> wallets = List.from(_user.wallets?? []);

      final index = wallets.indexWhere((obj) => obj.externalId == walletExternalId);
      if(index >= 0){
        wallets[index] = wallet;
        setUser = _user.copyWith(
          wallets: wallets,
        );
      }
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Bank Updated',
          message: 'Bank account updated.',
          onButtonPressed: (){
            AppNavigator.of(context).pop();
          },
        ),
      );
    });
  }

  /// USER TYPE
  Future<void> userType(BuildContext context) async {
    setComponentErrorType = null;
    setLoading(true, component: 'userTypes');

    final result = await _userRepository.userType();

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'userTypes'
      };
      setLoading(false, component: 'userTypes');

    }, (right) {
      setUserTypes = right;
    });
  }


  Future<void> logout(BuildContext context) async{
    AppDialogUtil.loadingDialog(context);

    final result = await _userRepository.logout();

    if(context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      HelperUtil.logOut();

    }, (right) {
      HelperUtil.logOut();
    });
  }

  Future<void> _retrieveUser() async{
    final result = await _userRepository.retrieveUser();
    result.fold((l) => null, (user) => _user = user);
  }

  Future<void> _persistUser() async{
    final result = await _userRepository.persistUser(_user);
    result.fold((l) => null, (user) => null);
  }

  Future<bool> isLoggedIn() async => await _userRepository.isLoggedIn();

  initState() async{
    await _retrieveUser();
  }

}