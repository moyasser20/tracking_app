import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/use_cases/get_order_usecase.dart';
import 'home_states.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  final GetOrderUseCase _getOrdersUseCase;

  HomeCubit(this._getOrdersUseCase) : super(HomeInitialState());

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
