import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/meta_data_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_response_entity.dart';
import 'package:tarcking_app/features/homescreen/domain/repositories/home_repo.dart';
import 'package:tarcking_app/features/homescreen/domain/use_cases/get_order_usecase.dart';
import 'package:tarcking_app/core/errors/failure.dart';
import 'get_orders_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late MockHomeRepo mockHomeRepo;
  late GetOrderUseCase getOrderUseCase;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    getOrderUseCase = GetOrderUseCase(mockHomeRepo);
  });

  group('GetOrderUseCase', () {
    final fakeOrdersResponse = OrdersResponseEntity(
      message: "success",
      metadata: Metadata(
        currentPage: 1,
        totalPages: 1,
        totalItems: 0,
        limit: 10,
      ),
      orders: [],
    );

    test('✅ should return OrdersResponseEntity when repo succeeds', () async {
      // Arrange
      when(
        mockHomeRepo.getOrders(),
      ).thenAnswer((_) async => fakeOrdersResponse);

      // Act
      final result = await getOrderUseCase();

      // Assert
      expect(result, isA<OrdersResponseEntity>());
      expect(result.message, "success");
      verify(mockHomeRepo.getOrders()).called(1);
    });

    test('❌ should throw exception when repo throws', () async {
      // Arrange
      when(
        mockHomeRepo.getOrders(),
      ).thenThrow(ServerFailure(errorMessage: "API error"));

      // Act
      final call = getOrderUseCase;

      // Assert
      expect(() => call(), throwsA(isA<ServerFailure>()));
      verify(mockHomeRepo.getOrders()).called(1);
    });
  });
}
