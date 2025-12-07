// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersListResponse _$MyOrdersListResponseFromJson(
        Map<String, dynamic> json) =>
    MyOrdersListResponse(
      message: json['message'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderWrapperResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MyOrdersListResponseToJson(
        MyOrdersListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'orders': instance.orders,
      'metadata': instance.metadata,
    };
