// order_details_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_item_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/product_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/store_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/user_entity.dart';
import 'package:tarcking_app/features/order_details/data/models/order_details_model.dart';

void main() {
  group('OrderDetails', () {
    test('fromOrderEntity should create OrderDetails correctly', () {
      final orderEntity = OrderEntity(
        id: '1',
        createdAt: DateTime(2023, 1, 1),
        state: 'pending',
        orderNumber: 'ORD-001',
        store: StoreEntity(
          name: 'Test Store',
          address: 'Store Address, Cairo',
          phoneNumber: '+20123456789',
          image: '',
          latLong: '',
        ),
        user: UserEntity(
          id: 'user1',
          firstName: 'John',
          lastName: 'Doe',
          phone: '+20123456789',
          email: 'john@example.com',
          gender: 'male',
          photo: 'https://example.com/photo.jpg',
        ),
        orderItems: [
          OrderItemEntity(
            id: 'item1',
            product: ProductEntity(
              id: 'prod1',
              title: 'Test Product',
              description: 'Test Description',
              price: 50,
              images: [],
              category: 'Test Category',
              slug: '',
              imgCover: '',
              quantity: 4,
              sold: 0,
              occasion: '',
              rateAvg: 3.4,
              rateCount: 4,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            quantity: 2,
            price: 100,
          ),
        ],
        totalPrice: 100,
        paymentType: 'cash', wrapperId: '0',
        isPaid: false,
        isDelivered: false,
        updatedAt: DateTime.now(),
      );
      final orderDetails = OrderDetails.fromOrderEntity(orderEntity);

      expect(orderDetails.id, '1');
      expect(orderDetails.state, 'pending');
      expect(orderDetails.orderNumber, 'ORD-001');
      expect(orderDetails.pickupAddress.name, 'Test Store');
      expect(orderDetails.userAddress.name, 'John Doe');
      expect(orderDetails.items.length, 1);
      expect(orderDetails.items.first.name, 'Test Product');
      expect(orderDetails.total, 100.0);
      expect(orderDetails.paymentMethod, 'Cash on delivery');
      expect(orderDetails.arrivedAtPickup, false);
    });

    test('copyWith should create a new instance with updated fields', () {
      final original = OrderDetails(
        id: '1',
        createdAt: DateTime(2023, 1, 1),
        state: 'pending',
        orderNumber: 'ORD-001',
        pickupAddress: Address(
          name: 'Store',
          address: 'Store Address',
          phoneNumber: '+123456789',
        ),
        userAddress: Address(
          name: 'User',
          address: 'User Address',
          phoneNumber: '+987654321',
        ),
        items: [],
        total: 100.0,
        paymentMethod: 'cash',
        arrivedAtPickup: false, userId: '',
      );

      final copied = original.copyWith(state: 'completed', total: 150.0);

      expect(copied.id, '1');
      expect(copied.state, 'completed');
      expect(copied.total, 150.0);
      expect(copied.orderNumber, 'ORD-001');
      expect(copied.arrivedAtPickup, false);
    });
  });

  group('Address', () {
    test('should create Address with correct properties', () {
      final address = Address(
        name: 'Test Name',
        address: 'Test Address',
        phoneNumber: '+123456789',
      );

      expect(address.name, 'Test Name');
      expect(address.address, 'Test Address');
      expect(address.phoneNumber, '+123456789');
    });
  });

  group('OrderItem', () {
    test('should create OrderItem with correct properties', () {
      final orderItem = OrderItem(
        name: 'Test Product',
        quantity: 2,
        price: 50.0,
        productId: 'prod1',
      );

      expect(orderItem.name, 'Test Product');
      expect(orderItem.quantity, 2);
      expect(orderItem.price, 50.0);
      expect(orderItem.productId, 'prod1');
    });
  });
}
