
import 'package:aider_mobile_app/src/features/review/domain/review/review_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/domain/models/pagination/pagination_model.dart';

part 'review_history_model.freezed.dart';
part 'review_history_model.g.dart';


@freezed
class ReviewHistoryModel with _$ReviewHistoryModel {
  const factory ReviewHistoryModel({
    @Default([]) final List<ReviewModel> data,
    final PaginationModel? meta,
  }) = _ReviewHistoryModel;

  factory ReviewHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewHistoryModelFromJson(json);
}