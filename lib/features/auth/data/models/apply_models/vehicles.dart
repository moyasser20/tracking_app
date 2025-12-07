import 'package:json_annotation/json_annotation.dart';

part 'vehicles.g.dart';

@JsonSerializable()
class Vehicles {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  Vehicles({this.Id, this.type, this.image, this.createdAt, this.updatedAt});

  factory Vehicles.fromJson(Map<String, dynamic> json) {
    return _$VehiclesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehiclesToJson(this);
  }
}
