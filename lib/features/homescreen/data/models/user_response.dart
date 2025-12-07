import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "gender")
  final String? gender;

  UserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.photo,
    this.gender,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
