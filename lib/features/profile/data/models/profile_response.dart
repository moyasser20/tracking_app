import 'package:json_annotation/json_annotation.dart';
import 'package:tarcking_app/features/profile/data/models/user_model.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "driver")
  final User driver;

  ProfileResponse({required this.message, required this.driver});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }
}
