import 'package:json_annotation/json_annotation.dart';
import 'package:tarcking_app/features/homescreen/data/models/product_response.dart';

part 'my_order_item_response.g.dart';

@JsonSerializable()
class OrderItemResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "product")
  final ProductResponse? product;

  @JsonKey(name: "price")
  final int? price;

  @JsonKey(name: "quantity")
  final int? quantity;

  OrderItemResponse({this.id, this.product, this.price, this.quantity});

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemResponseToJson(this);
}