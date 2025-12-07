import 'package:json_annotation/json_annotation.dart';
import 'package:tarcking_app/features/profile/data/models/user_model.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "driver")
  final User driver;

  EditProfileResponseModel({required this.message, required this.driver});

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return _$EditProfileResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileResponseModelToJson(this);
  }
}
