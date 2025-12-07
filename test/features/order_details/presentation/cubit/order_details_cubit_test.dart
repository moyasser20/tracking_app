import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tarcking_app/core/api/client/api_client.dart';
import 'package:tarcking_app/core/firebase/firebase_service.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/store_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/user_entity.dart';
import 'package:tarcking_app/features/order_details/data/models/order_details_model.dart';
import 'package:tarcking_app/features/order_details/data/models/update_order_state_response_model.dart';
import 'package:tarcking_app/features/order_details/presentation/cubit/order_details_cubit.dart';

import 'order_details_cubit_test.mocks.dart';

// FIX: Added FirestoreService to the mocks list
@GenerateMocks([ApiClient, FirestoreService])
void main() {
  late MockApiClient mockApiClient;
  late MockFirestoreService mockFirestoreService;
  late OrderDetailsCubit orderDetailsCubit;
  late OrderEntity mockOrderEntity;

  setUp(() {
    mockApiClient = MockApiClient();
    mockFirestoreService = MockFirestoreService();
    orderDetailsCubit = OrderDetailsCubit(mockApiClient, mockFirestoreService);

    mockOrderEntity = OrderEntity(
      id: '1',
      createdAt: DateTime.now(),
      state: 'pending',
      orderNumber: 'ORD-001',
      store: StoreEntity(
        name: 'Test Store',
        image: 'https://example.com/store-image.jpg',
        latLong: '21.13425352',
        address: 'Store Address',
        phoneNumber: '+1234567890',
      ),
      user: UserEntity(
        id: 'user1',
        firstName: 'John',
        lastName: 'Doe',
        phone: '+0987654321',
        email: 'john@example.com',
        gender: 'male',
        photo: '+201111111111',
      ),
      orderItems: [],
      totalPrice: 130,
      paymentType: 'cash',
      wrapperId: '12',
      isPaid: false,
      isDelivered: false,
      updatedAt: DateTime.now(),
    );
  });

  tearDown(() {
    orderDetailsCubit.close();
  });

  group('OrderDetailsCubit', () {
    test('initial state is OrderDetailsInitial', () {
      expect(orderDetailsCubit.state, isA<OrderDetailsInitial>());
    });

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [OrderDetailsLoading, OrderDetailsLoaded] when getOrderDetails is called successfully',
      build: () => orderDetailsCubit,
      act: (cubit) => cubit.getOrderDetails(mockOrderEntity),
      expect: () => [isA<OrderDetailsLoading>(), isA<OrderDetailsLoaded>()],
    );


    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [OrderDetailsUpdating, OrderDetailsLoaded] when updateOrderStatus is called successfully',
      build: () {
        when(mockApiClient.updateOrderState(any, any)).thenAnswer(
              (_) async => UpdateOrderStateResponse(
            message: 'Success',orderId: '', state: '', // Mock response
          ),
        );
        return orderDetailsCubit;
      },
      seed:
          () =>
          OrderDetailsLoaded(OrderDetails.fromOrderEntity(mockOrderEntity)),
      act: (cubit) => cubit.updateOrderStatus(),
      expect: () => [isA<OrderDetailsUpdating>(), isA<OrderDetailsLoaded>()],
      verify: (_) {
        verify(mockApiClient.updateOrderState(any, any)).called(1);
      },
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [OrderDetailsUpdating, OrderDetailsError, OrderDetailsLoaded] when updateOrderStatus fails',
      build: () {
        when(
          mockApiClient.updateOrderState(any, any),
        ).thenThrow(Exception('Network error'));
        return orderDetailsCubit;
      },
      seed:
          () =>
          OrderDetailsLoaded(OrderDetails.fromOrderEntity(mockOrderEntity)),
      act: (cubit) => cubit.updateOrderStatus(),
      expect:
          () => [
        isA<OrderDetailsUpdating>(),
        isA<OrderDetailsError>(),
        isA<OrderDetailsLoaded>(),
      ],
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'does nothing when updateOrderStatus is called on completed order',
      build: () => orderDetailsCubit,
      seed:
          () => OrderDetailsLoaded(
        OrderDetails.fromOrderEntity(
          mockOrderEntity,
        ).copyWith(state: 'completed'),
      ),
      act: (cubit) => cubit.updateOrderStatus(),
      expect: () => [],
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'does nothing when updateOrderStatus is called on canceled order',
      build: () => orderDetailsCubit,
      seed:
          () => OrderDetailsLoaded(
        OrderDetails.fromOrderEntity(
          mockOrderEntity,
        ).copyWith(state: 'canceled'),
      ),
      act: (cubit) => cubit.updateOrderStatus(),
      expect: () => [],
    );
  });

  group('_getNextState', () {
    test('returns correct next state for pending', () {
      expect(orderDetailsCubit.getNextStateForTest('pending'), 'inProgress');
    });

    test('returns correct next state for inProgress', () {
      expect(orderDetailsCubit.getNextStateForTest('inProgress'), 'completed');
    });

    test('returns completed for completed state', () {
      expect(orderDetailsCubit.getNextStateForTest('completed'), 'completed');
    });

  });
}

extension on OrderDetailsCubit {
  String getNextStateForTest(String currentState) {
    return getNextState(currentState);
  }
}