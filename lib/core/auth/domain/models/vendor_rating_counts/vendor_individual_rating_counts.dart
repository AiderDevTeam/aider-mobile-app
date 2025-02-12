class VendorIndividualRatingCountsModel {
  final int? id;
  final int? oneRating;
  final int? twoRating;
  final int? threeRating;
  final int? fourRating;
  final int? fiveRating;

  const VendorIndividualRatingCountsModel({
    this.id,
    this.oneRating,
    this.twoRating,
    this.threeRating,
    this.fourRating,
    this.fiveRating,
  });

  factory VendorIndividualRatingCountsModel.fromJson(
      Map<String, dynamic> json) {
    return VendorIndividualRatingCountsModel(
      id: json['id'],
      oneRating: json['oneRating'],
      twoRating: json['twoRating'],
      threeRating: json['threeRating'],
      fourRating: json['fourRating'],
      fiveRating: json['fiveRating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'oneRating': oneRating,
      'twoRating': twoRating,
      'threeRating': threeRating,
      'fourRating': fourRating,
      'fiveRating': fiveRating,
    };
  }
}
