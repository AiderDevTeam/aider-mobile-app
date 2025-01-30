import 'package:aider_mobile_app/core/auth/domain/models/statistics/statistic_model.dart';
import 'package:aider_mobile_app/src/features/kyc/domain/verification_model/verification_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/address/address_model.dart';
import '../wallet/wallet_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    final int? id,
    final String? uid,
    final String? externalId,
    final String? firstName,
    final String? lastName,
    final String? displayName,
    final String? gender,
    final String? email,
    final String? password,
    final String? callingCode,
    final String? phone,
    final String? birthday,
    final String? idVerificationStatus,
    final bool? idVerified,
    final String? joinedAt,
    final String? profilePhotoUrl,
    final int? itemsListed,
    final List<AddressModel>? addresses,
    final StatisticModel? statistics,
    final List<WalletModel>? wallets,
    final List<VerificationModel>? userIdentifications,
    final bool? canReceiveSMS,
    final bool? canReceiveEmailUpdates,
    final bool? canReceivePushNotifications,
    final bool? hasDefaultWallet,
    final String? pushNotificationToken,
    final String? userTypeId,
    final bool? termsAndConditions,
    final String? deviceOs,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  AddressModel? get address => addresses?.first;

  VerificationModel? get userIdentification => userIdentifications?.first;

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  String get greetingName {
    if ((firstName ?? '').isEmpty) return '';
    final splitNameList = (firstName ?? '').replaceAll('-', ' ').split(' ');
    return splitNameList.first;
  }

  bool get hasProfilePhoto => (profilePhotoUrl ?? '').isNotEmpty;

  bool get userHasWallet => hasDefaultWallet ?? false;
}
