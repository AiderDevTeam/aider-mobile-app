import 'package:freezed_annotation/freezed_annotation.dart';

class StringToNumConverter implements JsonConverter<num, dynamic> {
  const StringToNumConverter();

  @override
  num fromJson(dynamic json) => num.parse((json?? '0').toString());

  @override
  num toJson(num object) => object;
}

class StringToIntConverter implements JsonConverter<int, dynamic> {
  const StringToIntConverter();

  @override
  int fromJson(dynamic json) => int.parse((json?? '0').toString());

  @override
  int toJson(int object) => object;
}


class NumToStringConverter implements JsonConverter<String, dynamic> {
  const NumToStringConverter();

  @override
  String fromJson(dynamic json) => (json?? '').toString();

  @override
  String toJson(String object) => object;
}
