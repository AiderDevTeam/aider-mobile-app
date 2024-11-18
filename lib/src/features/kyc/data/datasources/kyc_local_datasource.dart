// import 'package:aider_mobile_app/src/features/kyc/domain/verification_model/verification_model.dart';
//
// import '../../../../../core/services/local_storage_service.dart';
// import '../../../../../core/services/logger_service.dart';
//
// abstract class KycLocalDatasource{
//   Future<VerificationModel> retrieveKyc();
//   Future<void> persistKyc(VerificationModel kyc);
// }
//
// class KycLocalDatasourceImpl extends KycLocalDatasource{
//
//   KycLocalDatasourceImpl({required this.localStorageService,});
//
//   final LocalStorageService localStorageService;
//
//
//   @override
//   Future<void> persistKyc(VerificationModel kyc) async{
//     await localStorageService.encodeAndWrite('Kyc', kyc.toJson());
//     ZLoggerService.logOnInfo('PERSISTED KYC HISTORY');
//   }
//
//   @override
//
//   Future<VerificationModel> retrieveKyc() async{
//     Map<String, dynamic> kycData = await localStorageService.decodeAndReadMap('Kyc');
//     ZLoggerService.logOnInfo('RETRIEVING Kyc');
//     return VerificationModel.fromJson(kycData);
//   }
//
// }