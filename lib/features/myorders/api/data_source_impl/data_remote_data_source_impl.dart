import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/client/api_client.dart';
import '../../../../core/errors/failure.dart';
import '../../data/datasource/my_orders_remote_data_source.dart';
import '../../data/models/my_order_list_response.dart';

@LazySingleton(as: MyOrdersRemoteDataSource)
class MyOrdersRemoteDataSourceImpl implements MyOrdersRemoteDataSource {
  final ApiClient apiClient;

  MyOrdersRemoteDataSourceImpl(this.apiClient);

  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ??
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ??
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  @override
  Future<MyOrdersListResponse> getAllOrders() async {
    try {
      return await apiClient.getAllOrders(
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2NzhhNTlmYTNjMzc5NzQ5Mjc0N2M4ZDQiLCJpYXQiOjE3MzcxMjAyNTB9.f-A1rvElymvDhEQM9bjqGl56O4c5Z8mhh7MkevnpqVQ",

      );
    } on DioException catch (e) {
      throw ServerFailure(errorMessage: _extractApiMessage(e));
    } catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }

}