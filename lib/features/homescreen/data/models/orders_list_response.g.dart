// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersListResponse _$OrdersListResponseFromJson(Map<String, dynamic> json) =>
    OrdersListResponse(
      message: json['message'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrdersListResponseToJson(OrdersListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'orders': instance.orders,
      'metadata': instance.metadata,
    };
