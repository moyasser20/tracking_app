import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "role")
  final String? role;

  @JsonKey(name: "country")
  final String? country;

  @JsonKey(name: "vehicleType")
  final String? vehicleType;

  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;

  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;

  @JsonKey(name: "NID")
  final String? nid;

  @JsonKey(name: "NIDImg")
  final String? nidImg;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.country,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
