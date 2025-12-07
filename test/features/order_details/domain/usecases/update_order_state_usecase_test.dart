import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/features/order_details/domain/repos/order_details_repo.dart';
import 'package:tarcking_app/features/order_details/domain/use_cases/update_order_state_usecase.dart';
import 'package:tarcking_app/features/order_details/data/models/update_order_state_response_model.dart';

import 'update_order_state_usecase_test.mocks.dart';

@GenerateMocks([OrderDetailsRepo])
void main() {
  late MockOrderDetailsRepo mockOrderDetailsRepo;
  late UpdateOrderStateUseCase updateOrderStateUseCase;

  setUp(() {
    mockOrderDetailsRepo = MockOrderDetailsRepo();
    updateOrderStateUseCase = UpdateOrderStateUseCase(mockOrderDetailsRepo);
  });

  group('UpdateOrderStateUseCase', () {
    const orderId = 'order123';
    const state = 'completed';
    final response = UpdateOrderStateResponse(
      message: 'Order updated successfully',
      orderId: '',
      state: '',
    );

    test('should call repository with correct parameters', () async {
      // Arrange
      when(
        mockOrderDetailsRepo.updateOrderState(orderId: orderId, state: state),
      ).thenAnswer((_) async => response);

      // Act
      final result = await updateOrderStateUseCase(
        orderId: orderId,
        state: state,
      );

      // Assert
      expect(result, response);
      verify(
        mockOrderDetailsRepo.updateOrderState(orderId: orderId, state: state),
      ).called(1);
    });

    test('should propagate exceptions from repository', () async {
      // Arrange
      when(
        mockOrderDetailsRepo.updateOrderState(orderId: orderId, state: state),
      ).thenThrow(Exception('Repository error'));

      // Act & Assert
      expect(
        () async =>
            await updateOrderStateUseCase(orderId: orderId, state: state),
        throwsA(isA<Exception>()),
      );
    });
  });
}
