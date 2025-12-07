import 'package:tarcking_app/features/homescreen/domain/entities/order_item_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/store_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/user_entity.dart';

class OrderEntity {
  final String wrapperId;
  final String id;
  final UserEntity user;
  final List<OrderItemEntity> orderItems;
  final int totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String orderNumber;
  final StoreEntity store;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderEntity({
    required this.wrapperId,
    required this.id,
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.orderNumber,
    required this.store,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderEntity copyWith({
    String? wrapperId,
    String? id,
    UserEntity? user,
    List<OrderItemEntity>? orderItems,
    int? totalPrice,
    String? paymentType,
    bool? isPaid,
    bool? isDelivered,
    String? state,
    String? orderNumber,
    StoreEntity? store,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderEntity(
      wrapperId: wrapperId ?? this.wrapperId,
      id: id ?? this.id,
      user: user ?? this.user,
      orderItems: orderItems ?? this.orderItems,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentType: paymentType ?? this.paymentType,
      isPaid: isPaid ?? this.isPaid,
      isDelivered: isDelivered ?? this.isDelivered,
      state: state ?? this.state,
      orderNumber: orderNumber ?? this.orderNumber,
      store: store ?? this.store,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}