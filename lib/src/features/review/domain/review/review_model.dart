import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/auth/domain/models/user/user_model.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    final int? id,
    final String? externalId,
    final int? rating,
    final String? productUid,
    final String? renterUid,
    final String? vendorUid,
    final String? comment,
    final String? postedAt,
    final String? time,
    final String? date,
    final UserModel? reviewer,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
