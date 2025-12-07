import 'package:tarcking_app/features/homescreen/data/models/orders_list_response.dart';

abstract class HomeRemoteDataSource {
  Future<OrdersListResponse> getOrders();
}
