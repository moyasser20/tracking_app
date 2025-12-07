import 'package:dio/dio.dart';
import '../models/apply_models/driver.dart';
import '../models/apply_models/vehicles_response.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_response.dart';
import 'package:tarcking_app/features/auth/domain/responses/auth_response.dart';
import '../models/forget_password_models/forget_password_request.dart';
import '../models/forget_password_models/reset_password_request_model.dart';
import '../models/forget_password_models/verify_code_request_model.dart';

abstract class AuthRemoteDatasource {
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
  });

  Future<VehiclesResponse> getVehicles();
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
  Future<AuthResponse<String>> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  );
  Future<AuthResponse<String>> verifyResetPassword(
    VerifyCodeRequestModel verifyCodeRequestModel,
  );
  Future<AuthResponse<String>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  );
  Future<String> logout();
}
