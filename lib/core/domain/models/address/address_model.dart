import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 1)
class AddressModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? uid;
  @HiveField(2)
  final String? externalId;
  @HiveField(3)
  final String? city;
  @HiveField(4)
  final String? originName;
  @HiveField(5)
  final String? country;
  @HiveField(6)
  final String? countryCode;
  @HiveField(7)
  final double? latitude;
  @HiveField(8)
  final double? longitude;

  const AddressModel({
    this.id,
    this.uid,
    this.externalId,
    this.city,
    this.originName,
    this.country,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      uid: json['uid'],
      externalId: json['externalId'],
      city: json['city'],
      originName: json['originName'],
      country: json['country'],
      countryCode: json['countryCode'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'externalId': externalId,
      'city': city,
      'originName': originName,
      'country': country,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class AddressList {
  AddressList({required this.list});
  final List<AddressModel> list;

  factory AddressList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => AddressModel.fromJson(obj)).toList();
    return AddressList(list: list);
  }
}
