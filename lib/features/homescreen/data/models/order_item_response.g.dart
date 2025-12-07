// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemResponse _$OrderItemResponseFromJson(Map<String, dynamic> json) =>
    OrderItemResponse(
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : ProductResponse.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemResponseToJson(OrderItemResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
    };
