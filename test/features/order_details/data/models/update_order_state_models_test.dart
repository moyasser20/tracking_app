import 'package:flutter_test/flutter_test.dart';
import 'package:tarcking_app/features/order_details/data/models/update_order_state_request_model.dart';
import 'package:tarcking_app/features/order_details/data/models/update_order_state_response_model.dart';

void main() {
  group('UpdateOrderStateRequest', () {
    test('toJson should return correct map', () {
      // Arrange
      const state = 'inProgress';
      final request = UpdateOrderStateRequest(state: state);

      // Act
      final json = request.toJson();

      // Assert
      expect(json, {'state': state});
    });

    test('should create request with correct state', () {
      // Arrange & Act
      const state = 'completed';
      final request = UpdateOrderStateRequest(state: state);

      // Assert
      expect(request.state, state);
    });
  });

  group('UpdateOrderStateResponse', () {
    test('fromJson should create response correctly', () {
      // Arrange
      final json = {
        'message': 'Order updated successfully',
        'orders': {
          'id': 'order1',
          'state': 'completed',
          // ... other order properties
        },
      };

      // Act
      final response = UpdateOrderStateResponse.fromJson(json);

      // Assert
      expect(response.message, 'Order updated successfully');
      expect(response.orderId, isNotNull);
    });

    test('fromJson should handle null message', () {
      // Arrange
      final json = {
        'orders': {
          'id': 'order1',
          'state': 'completed',
        },
      };

      // Act
      final response = UpdateOrderStateResponse.fromJson(json);

      // Assert
      expect(response.message, '');
      expect(response.orderId, isNotNull);
    });
  });
}