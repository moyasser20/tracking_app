// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicles _$VehiclesFromJson(Map<String, dynamic> json) => Vehicles(
      Id: json['_id'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$VehiclesToJson(Vehicles instance) => <String, dynamic>{
      '_id': instance.Id,
      'type': instance.type,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
