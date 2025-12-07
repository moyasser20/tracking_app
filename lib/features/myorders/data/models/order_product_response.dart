import 'package:json_annotation/json_annotation.dart';

part 'order_product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "price")
  final int? price;

  ProductResponse({this.id, this.title, this.price});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}