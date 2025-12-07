import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
import '../../../../core/errors/failure.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_response.dart';
import 'package:tarcking_app/features/auth/domain/responses/auth_response.dart';
import '../../../../core/api/client/api_client.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/models/apply_models/driver.dart';
import '../../data/models/apply_models/vehicles_response.dart';
import '../api_client/apply_api_client.dart';
import '../../data/models/forget_password_models/forget_password_request.dart';
import '../../data/models/forget_password_models/reset_password_request_model.dart';
import '../../data/models/forget_password_models/verify_code_request_model.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApplyApiClient _apiClient;
  final ApiClient _authApiClient;
  AuthRemoteDatasourceImpl(this._apiClient, this._authApiClient);

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
  Future<Driver> applyDriver({
    required String country,
    required String firstName,
    required String lastName,
    required String vehicleType,
    required String vehicleNumber,
    required MultipartFile vehicleLicense,
    required String nid,
    required MultipartFile nidImg,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required String phone,
  }) async {
    try {
      final response = await _apiClient.applyDriver(
        country: country,
        firstName: firstName,
        lastName: lastName,
        vehicleType: vehicleType,
        vehicleNumber: vehicleNumber,
        vehicleLicense: vehicleLicense,
        nid: nid,
        nidImg: nidImg,
        email: email,
        password: password,
        rePassword: rePassword,
        gender: gender,
        phone: phone,
      );

      return response.driver;
    } on DioException catch (e) {
      throw Exception(_extractApiMessage(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<VehiclesResponse> getVehicles() async {
    try {
      final response = await _apiClient.getVehicles();
      return response;
    } on DioException catch (e) {
      throw Exception(_extractApiMessage(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await _authApiClient.login(loginRequest);
      return AuthResponse.success(response);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  ) async {
    try {
      final result = await _authApiClient.forgetPassword(
        forgetPasswordRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) async {
    try {
      final result = await _authApiClient.resetPassword(
        resetPasswordRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> verifyResetPassword(
    VerifyCodeRequestModel verifyCodeRequestModel,
  ) async {
    try {
      final result = await _authApiClient.verifyResetCode(
        verifyCodeRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<String> logout() async {
    return await _authApiClient.logout();
  }
}
