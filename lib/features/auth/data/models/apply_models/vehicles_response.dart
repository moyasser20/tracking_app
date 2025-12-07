import 'package:json_annotation/json_annotation.dart';
import 'vehicles.dart';

part 'vehicles_response.g.dart';

@JsonSerializable()
class VehiclesResponse {
  final String? message;
  final List<Vehicles>? vehicles;

  VehiclesResponse({this.message, this.vehicles});

  factory VehiclesResponse.fromJson(Map<String, dynamic> json) =>
      _$VehiclesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesResponseToJson(this);
}
