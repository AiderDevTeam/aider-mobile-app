class ExchangeScheduleModel {
  final String? externalId;
  final String? city;
  final String? status;
  final String? country;
  final String? countryCode;
  final String? originName;
  final String? timeOfExchange;

  ExchangeScheduleModel({
    this.externalId,
    this.city,
    this.status,
    this.country,
    this.countryCode,
    this.originName,
    this.timeOfExchange,
  });
  Map<String, dynamic> toJson() {
    return {
      'external_id': externalId,
      'city': city,
      'status': status,
      'country': country,
      'countryCode': countryCode,
      'originName': originName,
      'timeOfExchange': timeOfExchange,
    };
  }

  factory ExchangeScheduleModel.fromJson(Map<String, dynamic> json) {
    return ExchangeScheduleModel(
      externalId: json['external_id'],
      city: json['city'],
      status: json['status'],
      country: json['country'],
      countryCode: json['countryCode'],
      originName: json['originName'],
      timeOfExchange: json['timeOfExchange'],
    );
  }
}
