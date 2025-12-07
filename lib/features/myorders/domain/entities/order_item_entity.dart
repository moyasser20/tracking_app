import 'package:tarcking_app/features/myorders/domain/entities/product_entity.dart';

class OrderItemEntity {
  final String id;
  final ProductEntity product;
  final int price;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });
}