// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesResponse _$VehiclesResponseFromJson(Map<String, dynamic> json) =>
    VehiclesResponse(
      message: json['message'] as String?,
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => Vehicles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VehiclesResponseToJson(VehiclesResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'vehicles': instance.vehicles,
    };
