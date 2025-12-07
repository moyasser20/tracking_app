import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/auth/data/models/apply_models/apply_response.dart';

import '../../data/models/apply_models/vehicles_response.dart';

@lazySingleton
class ApplyApiClient {
  final Dio _dio;

  static const String _baseUrl = "https://flower.elevateegy.com/api/v1";

  ApplyApiClient(this._dio);

  Future<ApplyResponse> applyDriver({
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
    final formData = FormData.fromMap({
      'country': country,
      'firstName': firstName,
      'lastName': lastName,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'vehicleLicense': vehicleLicense,
      'NID': nid,
      'NIDImg': nidImg,
      'email': email,
      'password': password,
      'rePassword': rePassword,
      'gender': gender,
      'phone': phone,
    });

    final response = await _dio.post("$_baseUrl/drivers/apply", data: formData);

    return ApplyResponse.fromJson(response.data);
  }

  Future<VehiclesResponse> getVehicles() async {
    final response = await _dio.get("$_baseUrl/vehicles");
    return VehiclesResponse.fromJson(response.data);
  }
}
