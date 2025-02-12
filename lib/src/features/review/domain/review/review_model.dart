import '../../../../../core/auth/domain/models/user/user_model.dart';

class ReviewModel {
  final int? id;
  final String? externalId;
  final int? rating;
  final String? productUid;
  final String? renterUid;
  final String? vendorUid;
  final String? bookingUid;
  final String? comment;
  final String? postedAt;
  final String? time;
  final String? date;
  final UserModel? reviewer;

  const ReviewModel({
    this.id,
    this.externalId,
    this.rating,
    this.productUid,
    this.renterUid,
    this.vendorUid,
    this.bookingUid,
    this.comment,
    this.postedAt,
    this.time,
    this.date,
    this.reviewer,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      externalId: json['externalId'],
      rating: json['rating'],
      productUid: json['productUid'],
      renterUid: json['renterUid'],
      vendorUid: json['vendorUid'],
      bookingUid: json['bookingUid'],
      comment: json['comment'],
      postedAt: json['postedAt'],
      time: json['time'],
      date: json['date'],
      reviewer: json['reviewer'] != null
          ? UserModel.fromJson(json['reviewer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'externalId': externalId,
      'rating': rating,
      'productUid': productUid,
      'renterUid': renterUid,
      'vendorUid': vendorUid,
      'bookingUid': bookingUid,
      'comment': comment,
      'postedAt': postedAt,
      'time': time,
      'date': date,
      'reviewer': reviewer?.toJson(),
    };
  }
}
