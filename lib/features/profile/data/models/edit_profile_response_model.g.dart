// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileResponseModel _$EditProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    EditProfileResponseModel(
      message: json['message'] as String,
      driver: User.fromJson(json['driver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditProfileResponseModelToJson(
        EditProfileResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'driver': instance.driver,
    };
