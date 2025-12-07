import 'meta_data_entity.dart';
import 'order_entity.dart';

class OrdersResponseEntity {
  final String message;
  final Metadata metadata;
  final List<OrderEntity> orders;

  OrdersResponseEntity({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  OrdersResponseEntity copyWith({
    List<OrderEntity>? orders,
    Metadata? metadata,
    String? message,
  }) {
    return OrdersResponseEntity(
      orders: orders ?? this.orders,
      metadata: metadata ?? this.metadata,
      message: message ?? this.message,
    );
  }
}