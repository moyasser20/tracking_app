import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_entity.dart';
import 'package:tarcking_app/features/homescreen/presentation/viewmodel/home_cubit.dart';
import 'package:tarcking_app/features/order_details/data/models/order_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/api/client/api_client.dart';
import '../../../../core/config/di.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../../data/models/update_order_state_request_model.dart';

part 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final ApiClient _apiClient;
  final FirestoreService _firestoreService;
  OrderEntity? currentOrderEntity;

  OrderDetailsCubit(this._apiClient, this._firestoreService)
    : super(OrderDetailsInitial());

  void getOrderDetails(OrderEntity orderEntity) {
    currentOrderEntity = orderEntity;
    emit(OrderDetailsLoading());
    try {
      final order = OrderDetails.fromOrderEntity(orderEntity);

      log('Order loaded - Initial state: ${order.state}');
      log('Order items count: ${order.items.length}');

      emit(OrderDetailsLoaded(order));

      _sendOrderToUserApp(order, orderEntity.user.id);
    } catch (e) {
      log('Error loading order details: $e');
      emit(OrderDetailsError('Failed to load order details: $e'));
    }
  }

  Future<void> updateOrderStatus() async {
    if (state is OrderDetailsLoaded) {
      final currentState = state as OrderDetailsLoaded;
      final currentOrder = currentState.order;

      log('Current order state: ${currentOrder.state}');
      log('Current order ID: ${currentOrder.id}');

      if (currentOrder.state == 'canceled' ||
          currentOrder.state == 'completed') {
        return;
      }

      final nextState = getNextState(currentOrder.state);
      log('Next state: $nextState');

      final updatedOrder = currentOrder.copyWith(state: nextState);
      emit(OrderDetailsUpdating(updatedOrder));

      try {
        final request = UpdateOrderStateRequest(state: nextState);
        final response = await _apiClient.updateOrderState(
          currentOrder.id,
          request,
        );

        final confirmedState = response.state;
        final confirmedOrder = currentOrder.copyWith(state: confirmedState);

        await _sendOrderToUserApp(
          confirmedOrder,
          _getUserIdFromOrder(currentOrder),
        );
        await onUpdateButtonClicked(
          confirmedOrder,
          _getButtonTextForState(confirmedState),
        );

        emit(OrderDetailsLoaded(confirmedOrder));
        _refreshHomeOrders();
      } catch (e, s) {
        log('Error updating order status: $e');
        log('Stack trace: $s');
        emit(OrderDetailsError('Failed to update order status: $e'));
        emit(OrderDetailsLoaded(currentOrder));
      }
    } else {
      log('Invalid state for update: ${state.runtimeType}');
    }
  }

  void _refreshHomeOrders() {
    try {
      final homeCubit = getIt<HomeCubit>();
      homeCubit.getOrders();
    } catch (e) {
      log('Could not refresh home orders: $e');
    }
  }

  Future<void> _sendOrderToUserApp(OrderDetails order, String userId) async {
    try {
      log('Sending order to Firestore - State: ${order.state}');
      final orderData = {
        ...order.toMap(),
        'update_order_button': _getButtonTextForState(order.state),
        'lastUpdated': FieldValue.serverTimestamp(),
      };

      await _firestoreService.sendOrderToUser(
        orderId: order.id,
        userId: userId,
        orderData: orderData,
      );

      log(
        'Order sent successfully with state: ${order.state} and button: ${_getButtonTextForState(order.state)}',
      );
    } catch (e, s) {
      log('Failed to send order to user app: $e');
      log('stackTrace for sendOrderToUserApp: $s');
    }
  }

  String _getUserIdFromOrder(OrderDetails order) {
    return order.userId;
  }

  String getNextState(String currentState) {
    switch (currentState) {
      case 'pending':
        return 'inProgress';
      case 'inProgress':
        return 'completed';
      case 'canceled':
      case 'completed':
        return currentState;
      default:
        return 'pending';
    }
  }

  String _getButtonTextForState(String state) {
    switch (state) {
      case 'pending':
        return 'Preparing your order';
      case 'inProgress':
        return 'Out for delivery';
      case 'canceled':
        return 'Canceled';
      case 'completed':
        return 'Delivered';
      default:
        return 'Update Order';
    }
  }

  void call(String phoneNumber) async {
    final url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      log("Phone is not installed");
    }
  }

  void shareViaWhatsApp(String phoneNumber) async {
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final phone =
        cleanedPhone.startsWith('+') ? cleanedPhone : '+$cleanedPhone';
    final url = Uri.parse("https://wa.me/$phone");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final phoneUrl = Uri.parse("tel:$phone");
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      }
    }
  }

  Future<void> onUpdateButtonClicked(
    OrderDetails order,
    String buttonText,
  ) async {
    try {
      log(
        'Update order button clicked - Order: ${order.id}, Button Text: $buttonText',
      );

      await _firestoreService.sendOrderToUser(
        orderId: order.id,
        userId: _getUserIdFromOrder(order),
        orderData: {
          ...order.toMap(),
          'update_order_button': buttonText,
          'button_clicked_at': FieldValue.serverTimestamp(),
        },
      );

      log(
        'Button click callback recorded in Firestore with button text: $buttonText',
      );
    } catch (e, s) {
      log('Failed to record button click callback: $e');
      log('StackTrace: $s');
    }
  }
}
