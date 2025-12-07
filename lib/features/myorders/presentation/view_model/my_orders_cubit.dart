import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/usecase/get_order_use_case.dart';
import 'my_order_states.dart';

@injectable
class MyOrdersCubit extends Cubit<MyOrderStates> {
  final GetOrderUseCase _getOrdersUseCase;

  MyOrdersCubit(this._getOrdersUseCase) : super(HomeInitialState());

  final Map<String, String> orderAddressMap = {};

  final List<String> addresses = [
    "Nasr City, Cairo",
    "6th of October, Giza",
    "Maadi, Cairo",
    "Dokki, Giza",
    "Heliopolis, Cairo",
  ];

  Future<void> getOrders() async {
    emit(HomeLoadingState());
    try {
      final ordersResponse = await _getOrdersUseCase();
      orderAddressMap.clear();

      for (int i = 0; i < ordersResponse.orders.length; i++) {
        final order = ordersResponse.orders[i];
        orderAddressMap[order.wrapperId] = addresses[i % addresses.length];
      }

      emit(HomeSuccessState(ordersResponse));
    } on Failure catch (failure) {
      emit(HomeErrorState(failure.errorMessage));
    } catch (e) {
      emit(HomeErrorState("Unexpected error: ${e.toString()}"));
    }
  }

  void rejectOrderLocally(String wrapperId) {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;

      final updatedOrders =
      currentState.ordersResponseEntity.orders
          .where((o) => o.wrapperId != wrapperId)
          .toList();

      emit(
        HomeSuccessState(
          currentState.ordersResponseEntity.copyWith(orders: updatedOrders),
        ),
      );
    }
  }
}