import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'LIVE_BASE_URL', obfuscate: true)
  static final String liveBaseUrl = _Env.liveBaseUrl;
  @EnviedField(varName: 'STAGING_BASE_URL', obfuscate: true)
  static final String stagingBaseUrl = _Env.stagingBaseUrl;
  @EnviedField(varName: 'SOCKET_BASE_URL', obfuscate: true)
  static final String socketBaseUrl = _Env.socketBaseUrl;
  @EnviedField(varName: 'SOCKET_KEY', obfuscate: true)
  static final String socketKey = _Env.socketKey;
  @EnviedField(varName: 'PRODUCTION')
  static const bool production = _Env.production;
  @EnviedField(varName: 'GOOGLE_MAP_KEY', obfuscate: true)
  static final String googleMapKey = _Env.googleMapKey;
  @EnviedField(varName: 'PAY_STACK_PK', obfuscate: true)
  static final String payStackPublicKey = _Env.payStackPublicKey;
  @EnviedField(varName: 'PAY_STACK_SK', obfuscate: true)
  static final String payStackSecretKey = _Env.payStackSecretKey;
  @EnviedField(varName: 'SUPPORT_WHATSAPP', obfuscate: true)
  static final String supportWhatsapp = _Env.supportWhatsapp;
  @EnviedField(varName: 'SUPPORT_INSTAGRAM', obfuscate: true)
  static final String supportInstagram = _Env.supportInstagram;
  @EnviedField(varName: 'EMAIL_ADDRESS', obfuscate: true)
  static final String supportEmail = _Env.supportEmail;
  @EnviedField(varName: 'CLOUDINARY_CLOUD_NAME', obfuscate: true)
  static final String cloudinaryCloudName = _Env.cloudinaryCloudName;
  @EnviedField(varName: 'CLOUDINARY_UPLOAD_PRESET', obfuscate: true)
  static final String cloudinaryUploadPreset = _Env.cloudinaryUploadPreset;
}
