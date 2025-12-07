import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/myorders/domain/repo/my_orders_repo.dart';
import '../entities/order_reponse_entity.dart';

@injectable
class GetOrderUseCase {
  final MyOrdersRepo _getAllOrdersRepo;

  GetOrderUseCase(this._getAllOrdersRepo);

  Future<OrdersResponseEntity> call() async {
    return await _getAllOrdersRepo.getAllOrders();
  }
}