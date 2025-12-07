import '../models/my_order_list_response.dart';

abstract class MyOrdersRemoteDataSource {
  Future<MyOrdersListResponse> getAllOrders();
}