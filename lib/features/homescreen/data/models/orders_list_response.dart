import 'package:json_annotation/json_annotation.dart';
import 'order_response.dart';

part 'orders_list_response.g.dart';

@JsonSerializable()
class OrdersListResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "orders")
  final List<OrderResponse>? orders;

  @JsonKey(name: "metadata")
  final Map<String, dynamic>? metadata;

  OrdersListResponse({this.message, this.orders, this.metadata});

  factory OrdersListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersListResponseToJson(this);
}
