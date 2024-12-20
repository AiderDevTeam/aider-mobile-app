import 'package:freezed_annotation/freezed_annotation.dart';


part 'product_photo_model.freezed.dart';
part 'product_photo_model.g.dart';

@freezed
class ProductPhotoModel with _$ProductPhotoModel {
  const factory ProductPhotoModel({
    final int? id,
    final String? externalId,
    final String? photoUrl,
  }) = _ProductPhotoModel;

  factory ProductPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPhotoModelFromJson(json);
}
