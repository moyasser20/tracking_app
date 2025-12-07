part of 'order_details_cubit.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}

final class OrderDetailsLoading extends OrderDetailsState {}

final class OrderDetailsLoaded extends OrderDetailsState {
  final OrderDetails order;

  OrderDetailsLoaded(this.order);
}

final class OrderDetailsUpdating extends OrderDetailsState {
  final OrderDetails order;

  OrderDetailsUpdating(this.order);
}

final class OrderDetailsError extends OrderDetailsState {
  final String message;

  OrderDetailsError(this.message);
}
