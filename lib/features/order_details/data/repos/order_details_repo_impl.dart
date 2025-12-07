import 'package:injectable/injectable.dart';

import '../../../../core/api/client/api_client.dart';
import '../../domain/repos/order_details_repo.dart';
import '../models/update_order_state_request_model.dart';
import '../models/update_order_state_response_model.dart';

@LazySingleton(as: OrderDetailsRepo)
class OrderDetailsRepoImpl implements OrderDetailsRepo {
  final ApiClient _apiClient;

  OrderDetailsRepoImpl(this._apiClient);

  @override
  Future<UpdateOrderStateResponse> updateOrderState({
    required String orderId,
    required String state,
  }) async {
    final request = UpdateOrderStateRequest(state: state);
    return await _apiClient.updateOrderState(orderId, request);
  }
}
