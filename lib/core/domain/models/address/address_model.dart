import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';


@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    final int? id,
    final String? externalId,
    final String? city,
    final String? originName,
    final String? country,
    final String? countryCode,
    final double? latitude,
    final double? longitude,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}



class AddressList {
  AddressList({required this.list});
  final List<AddressModel> list;

  factory AddressList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => AddressModel.fromJson(obj) ).toList();
    return AddressList(list: list);
  }

}