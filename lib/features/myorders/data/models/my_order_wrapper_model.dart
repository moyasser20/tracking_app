import 'package:json_annotation/json_annotation.dart';
import 'package:tarcking_app/features/homescreen/data/models/store_response.dart';

import 'my_order_response.dart';

part 'my_order_wrapper_model.g.dart';

@JsonSerializable()
class OrderWrapperResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "driver")
  final String? driver;

  @JsonKey(name: "order")
  final OrderResponse? order;

  @JsonKey(name: "store")
  final StoreResponse? store;

  OrderWrapperResponse({this.id, this.driver, this.order, this.store});

  factory OrderWrapperResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderWrapperResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderWrapperResponseToJson(this);
}