import '../entities/order_response_entity.dart';

abstract class HomeRepo {
  Future<OrdersResponseEntity> getOrders();
}
