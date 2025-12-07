import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/auth/domain/entities/apply_entites/driver_entity.dart';
import 'package:tarcking_app/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class ApplyDriverUseCase {
  final AuthRepo _repository;

  ApplyDriverUseCase(this._repository);

  Future<DriverEntity> call({
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
  }) {
    return _repository.applyDriver(
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicensePath: vehicleLicensePath,
      nid: nid,
      nidImgPath: nidImgPath,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      phone: phone,
    );
  }
}
