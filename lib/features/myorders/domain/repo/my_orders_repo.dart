import '../entities/order_reponse_entity.dart';

abstract class MyOrdersRepo {
  Future<OrdersResponseEntity> getAllOrders();
}