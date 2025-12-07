import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/core/api/client/api_client.dart';
import 'package:tarcking_app/features/order_details/data/repos/order_details_repo_impl.dart';
import 'package:tarcking_app/features/order_details/data/models/update_order_state_request_model.dart';
import 'package:tarcking_app/features/order_details/data/models/update_order_state_response_model.dart';

import 'order_details_repo_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late OrderDetailsRepoImpl orderDetailsRepo;

  setUp(() {
    mockApiClient = MockApiClient();
    orderDetailsRepo = OrderDetailsRepoImpl(mockApiClient);
  });

  group('OrderDetailsRepoImpl', () {
    const orderId = 'order123';
    const state = 'inProgress';
    final response = UpdateOrderStateResponse(
      message: 'Success',
      orderId: '',
      state: '',
    );

    test(
      'updateOrderState should call api client with correct parameters',
      () async {
        // Arrange
        when(
          mockApiClient.updateOrderState(
            any, // or argThat(equals(orderId))
            argThat(isA<UpdateOrderStateRequest>()),
          ),
        ).thenAnswer((invocation) async {
          // You can also verify the arguments here if needed
          final calledOrderId = invocation.positionalArguments[0] as String;
          final request =
              invocation.positionalArguments[1] as UpdateOrderStateRequest;

          expect(calledOrderId, orderId);
          expect(request.state, state);

          return response;
        });

        // Act
        final result = await orderDetailsRepo.updateOrderState(
          orderId: orderId,
          state: state,
        );

        // Assert
        expect(result, response);
        verify(mockApiClient.updateOrderState(any, any)).called(1);
      },
    );

    test('updateOrderState should propagate exceptions', () async {
      // Arrange
      when(
        mockApiClient.updateOrderState(any, any),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () async => await orderDetailsRepo.updateOrderState(
          orderId: orderId,
          state: state,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('updateOrderState should handle different order states', () async {
      // Test with different states
      const testCases = ['pending', 'inProgress', 'completed', 'canceled'];

      for (final testState in testCases) {
        // Arrange
        final testResponse = UpdateOrderStateResponse(
          message: 'Updated to $testState',
          orderId: '',
          state: '',
        );

        when(
          mockApiClient.updateOrderState(any, any),
        ).thenAnswer((_) async => testResponse);

        // Act
        final result = await orderDetailsRepo.updateOrderState(
          orderId: orderId,
          state: testState,
        );

        // Assert
        expect(result.message, 'Updated to $testState');
        verify(mockApiClient.updateOrderState(any, any)).called(1);

        // Clear interactions for next iteration
        clearInteractions(mockApiClient);
      }
    });
  });
}
