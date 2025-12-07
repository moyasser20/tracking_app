import 'package:json_annotation/json_annotation.dart';
import 'my_order_wrapper_response.dart';

part 'my_order_list_response.g.dart';

@JsonSerializable()
class MyOrdersListResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "orders")
  final List<OrderWrapperResponse>? orders;

  @JsonKey(name: "metadata")
  final Map<String, dynamic>? metadata;

  MyOrdersListResponse({this.message, this.orders, this.metadata});

  factory MyOrdersListResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrdersListResponseToJson(this);
}