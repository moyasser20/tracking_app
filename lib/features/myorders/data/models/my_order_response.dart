import 'package:json_annotation/json_annotation.dart';
import 'package:tarcking_app/features/homescreen/data/models/store_response.dart';
import 'package:tarcking_app/features/homescreen/data/models/user_response.dart';
import 'package:tarcking_app/features/homescreen/data/models/order_item_response.dart';

part 'my_order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "totalPrice")
  final int? totalPrice;

  @JsonKey(name: "state")
  final String? state;

  @JsonKey(name: "paymentType")
  final String? paymentType;

  @JsonKey(name: "orderNumber")
  final String? orderNumber;

  @JsonKey(name: "orderItems")
  final List<OrderItemResponse>? orderItems;

  @JsonKey(name: "isPaid")
  final bool? isPaid;

  @JsonKey(name: "isDelivered")
  final bool? isDelivered;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "store")
  final StoreResponse? store;

  @JsonKey(name: "user")
  final UserResponse? user;

  OrderResponse({
    this.id,
    this.totalPrice,
    this.state,
    this.paymentType,
    this.orderNumber,
    this.store,
    this.user,
    this.orderItems,
    this.isPaid,
    this.isDelivered,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}