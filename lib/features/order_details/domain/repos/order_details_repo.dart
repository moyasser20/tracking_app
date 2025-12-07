import '../../data/models/update_order_state_response_model.dart';

abstract class OrderDetailsRepo {
  Future<UpdateOrderStateResponse> updateOrderState({
    required String orderId,
    required String state,
  });
}
