import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/features/homescreen/api/data_sources_impl/home_remote_datasource_impl.dart';
import 'package:tarcking_app/features/homescreen/data/models/orders_list_response.dart';
import 'package:tarcking_app/core/errors/failure.dart';
import 'package:tarcking_app/core/api/client/api_client.dart';

import 'home_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late HomeRemoteDataSourceImpl dataSource;

  // The hardcoded values from the implementation file
  const hardcodedToken =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2NzhhNTlmYTNjMzc5NzQ5Mjc0N2M4ZDQiLCJpYXQiOjE3MzcxMjAyNTB9.f-A1rvElymvDhEQM9bjqGl56O4c5Z8mhh7MkevnpqVQ";
  const hardcodedLimit = 10;
  const hardcodedOffset = 1;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = HomeRemoteDataSourceImpl(mockApiClient);
  });

  group('getOrders', () {
    // Note: The local 'token' constant from the previous test is removed
    // because the method is not using it as an argument.

    test('should return OrdersListResponse when API call succeeds', () async {
      // arrange
      final ordersListResponse = OrdersListResponse(
        message: "Success",
        orders: [],
        metadata: {},
      );

      // FIX: The mock must match the EXACT hardcoded arguments used in the implementation
      when(
        mockApiClient.getOrders(
          hardcodedToken,
          hardcodedLimit,
          hardcodedOffset,
        ),
      ).thenAnswer((_) async => ordersListResponse);

      // act
      // FIX: No arguments are passed here because the implementation doesn't accept them
      final result = await dataSource.getOrders();

      // assert
      expect(result, isA<OrdersListResponse>());
      expect(result.message, "Success");
      // FIX: Verify the exact arguments were called
      verify(mockApiClient.getOrders(
        hardcodedToken,
        hardcodedLimit,
        hardcodedOffset,
      )).called(1);
    });

    test('should throw ServerFailure when DioException occurs', () async {
      // arrange
      // FIX: The mock must match the EXACT hardcoded arguments
      when(mockApiClient.getOrders(
        hardcodedToken,
        hardcodedLimit,
        hardcodedOffset,
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: "/orders"),
          response: Response(
            requestOptions: RequestOptions(path: "/orders"),
            statusCode: 400,
            data: {"message": "Bad Request"},
          ),
        ),
      );

      // act
      // FIX: The call is made without arguments
      final call = dataSource.getOrders;

      // assert
      // FIX: The call lambda is correct (no arguments)
      expect(() => call(), throwsA(isA<ServerFailure>()));
    });

    test(' should throw ServerFailure when unknown Exception occurs', () async {
      // arrange
      // FIX: The mock must match the EXACT hardcoded arguments
      when(mockApiClient.getOrders(
        hardcodedToken,
        hardcodedLimit,
        hardcodedOffset,
      )).thenThrow(Exception("Unexpected"));

      // act
      // FIX: The call is made without arguments
      final call = dataSource.getOrders;

      // assert
      // FIX: The call lambda is correct (no arguments)
      expect(() => call(), throwsA(isA<ServerFailure>()));
    });
  });
}