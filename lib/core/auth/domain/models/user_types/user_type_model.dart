import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_type_model.freezed.dart';
part 'user_type_model.g.dart';

@freezed
class UserTypeModel with _$UserTypeModel {
  const UserTypeModel._();

  factory UserTypeModel({
    final String? uid,
    final String? name,
    final String? description,
  }) = _UserTypeModel;

  factory UserTypeModel.fromJson(Map<String, dynamic> json) =>
      _$UserTypeModelFromJson(json);
}
