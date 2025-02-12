class RenterIndividualRatingCountsModel {
  final int? id;
  final int? oneRating;
  final int? twoRating;
  final int? threeRating;
  final int? fourRating;
  final int? fiveRating;

  const RenterIndividualRatingCountsModel({
    this.id,
    this.oneRating,
    this.twoRating,
    this.threeRating,
    this.fourRating,
    this.fiveRating,
  });

  factory RenterIndividualRatingCountsModel.fromJson(
      Map<String, dynamic> json) {
    return RenterIndividualRatingCountsModel(
      id: json['id'] as int?,
      oneRating: json['oneRating'] as int?,
      twoRating: json['twoRating'] as int?,
      threeRating: json['threeRating'] as int?,
      fourRating: json['fourRating'] as int?,
      fiveRating: json['fiveRating'] as int?,
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
