import '../entities/apply_entites/driver_entity.dart';
import '../entities/apply_entites/vehicle_enitity.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_response.dart';
import 'package:tarcking_app/features/auth/domain/responses/auth_response.dart';

abstract class AuthRepo {
  Future<DriverEntity> applyDriver({
    required String country,
    required String firstName,
    required String lastName,
    required String vehicleType,
    required String vehicleNumber,
    required String vehicleLicensePath,
    required String nid,
    required String nidImgPath,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required String phone,
  });

  Future<List<VehicleEntity>> getVehicles();
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
  Future<AuthResponse<String>> forgetPassword(String email);
  Future<AuthResponse<String>> verifyCode(String code);
  Future<AuthResponse<String>> resetPassword(String email, String newPassword);
  Future<String> logout();
}
