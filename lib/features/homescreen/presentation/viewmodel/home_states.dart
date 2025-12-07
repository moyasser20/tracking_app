import '../../domain/entities/order_response_entity.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final OrdersResponseEntity ordersResponseEntity;
  HomeSuccessState(this.ordersResponseEntity);
}

class HomeErrorState extends HomeStates {
  final String message;
  HomeErrorState(this.message);
}
