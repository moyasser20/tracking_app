import '../../domain/entities/order_reponse_entity.dart';

abstract class MyOrderStates {}

class HomeInitialState extends MyOrderStates {}

class HomeLoadingState extends MyOrderStates {}

class HomeSuccessState extends MyOrderStates {
  final OrdersResponseEntity ordersResponseEntity;
  HomeSuccessState(this.ordersResponseEntity);
}

class HomeErrorState extends MyOrderStates {
  final String message;
  HomeErrorState(this.message);
}