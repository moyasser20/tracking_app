import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/features/homescreen/data/data_sources/home_remote_datasource.dart';
import 'package:tarcking_app/features/homescreen/data/repositories/home_repo_impl.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_response_entity.dart';
import 'package:tarcking_app/features/homescreen/data/models/orders_list_response.dart';
import 'package:tarcking_app/core/errors/failure.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late HomeRepoImpl homeRepo;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    homeRepo = HomeRepoImpl(mockRemoteDataSource);
  });

  group('HomeRepoImpl.getOrders', () {
    test(
      'should return OrdersResponseEntity when remote data source succeeds',
      () async {
        final fakeDto = OrdersListResponse(
          message: "success",
          metadata: {
            "currentPage": 1,
            "totalPages": 1,
            "totalItems": 0,
            "limit": 10,
          },
          orders: [],
        );

        when(mockRemoteDataSource.getOrders()).thenAnswer((_) async => fakeDto);

        // Act
        final result = await homeRepo.getOrders();

        // Assert
        expect(result, isA<OrdersResponseEntity>());
        expect(result.message, "success");
        expect(result.orders, isEmpty);
        expect(result.metadata.currentPage, 1);
        verify(mockRemoteDataSource.getOrders()).called(1);
      },
    );

    test('should throw ServerFailure when remote data source throws', () async {
      // Arrange
      when(
        mockRemoteDataSource.getOrders(),
      ).thenThrow(ServerFailure(errorMessage: "API error"));

      // Act & Assert
      expect(() => homeRepo.getOrders(), throwsA(isA<ServerFailure>()));
      verify(mockRemoteDataSource.getOrders()).called(1);
    });
  });
}
