import 'env.dart';

class Environment {
  static bool get inDevMode => !Env.production;

  static String get getLiveBaseUrl => Env.liveBaseUrl;

  static String get getStagingBaseUrl => Env.stagingBaseUrl;

  static String get getBaseUrl =>
      inDevMode ? getStagingBaseUrl : getLiveBaseUrl;

  static String get getGoogleMapKey => Env.googleMapKey;

  static String get getPayStackPublicKey => Env.payStackPublicKey;

  static String get getPayStackSecretKey => Env.payStackSecretKey;

  static String get getSocketBaseUrl => Env.socketBaseUrl;

  static String get getSocketKey => Env.socketKey;

  static String get supportWhatsapp => Env.supportWhatsapp;

  static String get supportInstagram => Env.supportInstagram;

  static String get supportEmail => Env.supportEmail;

  static String get getCloudinaryCloudName => Env.cloudinaryCloudName;

  static String get getCloudinaryUploadPreset => Env.cloudinaryUploadPreset;
}
