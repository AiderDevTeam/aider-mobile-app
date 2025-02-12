class ProductPriceModel {
  final int? id;
  final String? externalId;
  final num? price;
  final int? startDay;
  final int? endDay;

  ProductPriceModel({
    this.id,
    this.externalId,
    this.price,
    this.startDay,
    this.endDay,
  });

  factory ProductPriceModel.fromJson(Map<String, dynamic> json) {
    return ProductPriceModel(
      id: json['id'],
      externalId: json['externalId'],
      price: json['price'],
      startDay: json['startDay'],
      endDay: json['endDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'externalId': externalId,
      'price': price,
      'startDay': startDay,
      'endDay': endDay,
    };
  }
}
