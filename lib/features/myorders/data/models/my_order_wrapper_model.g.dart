// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_wrapper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderWrapperResponse _$OrderWrapperResponseFromJson(
        Map<String, dynamic> json) =>
    OrderWrapperResponse(
      id: json['_id'] as String?,
      driver: json['driver'] as String?,
      order: json['order'] == null
          ? null
          : OrderResponse.fromJson(json['order'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : StoreResponse.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderWrapperResponseToJson(
        OrderWrapperResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'driver': instance.driver,
      'order': instance.order,
      'store': instance.store,
    };
