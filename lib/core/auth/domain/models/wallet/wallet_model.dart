
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';


@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    final int? id,
    final String? externalId,
    final String? bankName,
    final String? bankCode,
    final String? accountNumber,
    final String? accountName,
    @JsonKey(name: 'default') final bool? isDefault, // ignore_for_file: invalid_annotation_target
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}


class WalletList {
  WalletList({required this.list});
  final List<WalletModel> list;

  factory WalletList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => WalletModel.fromJson(obj) ).toList();
    return WalletList(list: list);
  }

}
