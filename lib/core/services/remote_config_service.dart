import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../env/environment.dart';

class RemoteConfigService {
  static final RemoteConfigService _remoteConfigService =
      RemoteConfigService._internal();
  factory RemoteConfigService() => _remoteConfigService;
  RemoteConfigService._internal();

  static final FirebaseRemoteConfig _firebaseRemoteConfig =
      FirebaseRemoteConfig.instance;
  static late RemoteConfigModel _configDataModel;

  Future<void> init() async {
    try {
      await _firebaseRemoteConfig.ensureInitialized();
      await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: Environment.inDevMode
            ? const Duration(seconds: 20)
            : const Duration(hours: 2),
      ));

      await _firebaseRemoteConfig.setDefaults(<String, dynamic>{
        'baseUrl': Environment.getLiveBaseUrl,
        'testBaseUrl': Environment.getStagingBaseUrl,
        'socketBaseUrl': Environment.getSocketBaseUrl,
        'googleMapKey': Environment.getGoogleMapKey,
        'socketKey': Environment.getSocketKey,
        'payStackPublicKey': Environment.getPayStackPublicKey,
        'payStackSecretKey': Environment.getPayStackSecretKey,
        'cloudinaryCloudName': Environment.getCloudinaryCloudName,
        'cloudinaryUploadPreset': Environment.getCloudinaryUploadPreset,
      });

      await _firebaseRemoteConfig.fetchAndActivate();

      _configDataModel = RemoteConfigModel.fromJson({
        'baseUrl': _firebaseRemoteConfig.getString('baseUrl'),
        'testBaseUrl': _firebaseRemoteConfig.getString('testBaseUrl'),
        'socketBaseUrl': _firebaseRemoteConfig.getString('socketBaseUrl'),
        'googleMapKey': _firebaseRemoteConfig.getString('googleMapKey'),
        'socketKey': _firebaseRemoteConfig.getString('socketKey'),
        'payStackPublicKey':
            _firebaseRemoteConfig.getString('payStackPublicKey'),
        'payStackSecretKey':
            _firebaseRemoteConfig.getString('payStackSecretKey'),
        'cloudinaryCloudName':
            _firebaseRemoteConfig.getString('cloudinaryCloudName'),
        'cloudinaryUploadPreset':
            _firebaseRemoteConfig.getString('cloudinaryUploadPreset'),
      });
      print('LIVE_BASE_URL 2: ${_firebaseRemoteConfig.getString('baseUrl')}');
    } catch (e) {
      _configDataModel = RemoteConfigModel(
        baseUrl: Environment.getLiveBaseUrl,
        testBaseUrl: Environment.getStagingBaseUrl,
        socketBaseUrl: Environment.getSocketBaseUrl,
        googleMapKey: Environment.getGoogleMapKey,
        socketKey: Environment.getSocketKey,
        payStackPublicKey: Environment.getPayStackPublicKey,
        payStackSecretKey: Environment.getPayStackSecretKey,
        cloudinaryCloudName: Environment.getCloudinaryCloudName,
        cloudinaryUploadPreset: Environment.getCloudinaryUploadPreset,
      );
      log(e.toString());
    }
  }

  static RemoteConfigModel get getRemoteData => _configDataModel;
}

class RemoteConfigModel {
  final String baseUrl;
  final String testBaseUrl;
  final String socketBaseUrl;
  final String googleMapKey;
  final String socketKey;
  final String payStackPublicKey;
  final String payStackSecretKey;
  final String cloudinaryCloudName;
  final String cloudinaryUploadPreset;

  RemoteConfigModel({
    required this.baseUrl,
    required this.testBaseUrl,
    required this.socketBaseUrl,
    required this.googleMapKey,
    required this.socketKey,
    required this.payStackPublicKey,
    required this.payStackSecretKey,
    required this.cloudinaryCloudName,
    required this.cloudinaryUploadPreset,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigModel(
      baseUrl: json['baseUrl'] ?? '',
      testBaseUrl: json['testBaseUrl'] ?? '',
      socketBaseUrl: json['socketBaseUrl'] ?? '',
      googleMapKey: json['googleMapKey'] ?? '',
      socketKey: json['socketKey'] ?? '',
      payStackPublicKey: json['payStackPublicKey'] ?? '',
      payStackSecretKey: json['payStackSecretKey'] ?? '',
      cloudinaryCloudName: json['cloudinaryCloudName'] ?? '',
      cloudinaryUploadPreset: json['cloudinaryUploadPreset'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
      'testBaseUrl': testBaseUrl,
      'socketBaseUrl': socketBaseUrl,
      'googleMapKey': googleMapKey,
      'socketKey': socketKey,
      'payStackPublicKey': payStackPublicKey,
      'payStackSecretKey': payStackSecretKey,
      'cloudinaryCloudName': cloudinaryCloudName,
      'cloudinaryUploadPreset': cloudinaryUploadPreset,
    };
  }
}
