import 'package:injectable/injectable.dart';
import '../../data/models/update_order_state_response_model.dart';
import '../repos/order_details_repo.dart';

@injectable
class UpdateOrderStateUseCase {
  final OrderDetailsRepo _orderDetailsRepo;

  UpdateOrderStateUseCase(this._orderDetailsRepo);

  Future<UpdateOrderStateResponse> call({
    required String orderId,
    required String state,
  }) async {
    return await _orderDetailsRepo.updateOrderState(
      orderId: orderId,
      state: state,
    );
  }
}