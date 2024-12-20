
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';


@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    final String? previous,
    final String? next,
    final int? currentPage,
    final int? perPage,
    final int? total,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

}
