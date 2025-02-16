import 'package:aider_mobile_app/src/features/review/domain/review/review_model.dart';

import '../../../../../../core/domain/models/pagination/pagination_model.dart';

class ReviewHistoryModel {
  final List<ReviewModel> data;
  final PaginationModel? meta;

  const ReviewHistoryModel({
    this.data = const [],
    this.meta,
  });

  ReviewHistoryModel copyWith({
    List<ReviewModel>? data,
    PaginationModel? meta,
  }) {
    return ReviewHistoryModel(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  factory ReviewHistoryModel.fromJson(Map<String, dynamic> json) {
    return ReviewHistoryModel(
      data: (json['data'] as List)
          .map<ReviewModel>((obj) => ReviewModel.fromJson(obj))
          .toList(),
      meta: PaginationModel.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((i) => i.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}
