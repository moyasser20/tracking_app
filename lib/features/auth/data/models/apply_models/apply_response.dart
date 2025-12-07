import 'package:json_annotation/json_annotation.dart';
import 'driver.dart';
part 'apply_response.g.dart';

@JsonSerializable()
class ApplyResponse {
  final String message;
  final Driver driver;
  final String token;

  ApplyResponse({
    required this.message,
    required this.driver,
    required this.token,
  });

  factory ApplyResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyResponseToJson(this);
}
