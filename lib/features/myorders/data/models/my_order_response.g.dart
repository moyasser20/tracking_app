// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      id: json['_id'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      state: json['state'] as String?,
      paymentType: json['paymentType'] as String?,
      orderNumber: json['orderNumber'] as String?,
      store: json['store'] == null
          ? null
          : StoreResponse.fromJson(json['store'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPaid: json['isPaid'] as bool?,
      isDelivered: json['isDelivered'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalPrice': instance.totalPrice,
      'state': instance.state,
      'paymentType': instance.paymentType,
      'orderNumber': instance.orderNumber,
      'orderItems': instance.orderItems,
      'isPaid': instance.isPaid,
      'isDelivered': instance.isDelivered,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'store': instance.store,
      'user': instance.user,
    };
