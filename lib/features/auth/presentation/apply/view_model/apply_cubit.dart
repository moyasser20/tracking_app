import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tarcking_app/core/contants/countries.dart';
import '../../../domain/entities/apply_entites/vehicle_enitity.dart';
import '../../../domain/usecases/apply/apply_driver_usecase.dart';
import '../../../domain/usecases/apply/vehicle_usecase.dart';
part 'apply_state.dart';

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  final ApplyDriverUseCase _applyDriverUseCase;
  final GetVehiclesUseCase _getVehiclesUseCase;

  ApplyCubit(this._applyDriverUseCase, this._getVehiclesUseCase)
    : super(ApplyInitial()) {
    selectedCountry = Countries.countryes.first;
  }

  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final vehicleLicenseController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nidController = TextEditingController();
  final nidImgController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  List<VehicleEntity> vehicles = [];
  VehicleEntity? selectedVehicle;

  dynamic selectedCountry;
  String? gender;
  String? vehicleLicensePath;
  String? nidImagePath;

  void setVehicleLicensePath(String? path) {
    vehicleLicensePath = path;
    if (path != null) {
      vehicleLicenseController.text = path.split('/').last;
    }
    emit(ApplyChanged());
  }

  void setNidImagePath(String? path) {
    nidImagePath = path;
    if (path != null) {
      nidImgController.text = path.split('/').last;
    }
    emit(ApplyChanged());
  }

  void setCountry(dynamic country) {
    selectedCountry = country;
    emit(ApplyChanged());
  }

  void setVehicleType(VehicleEntity? vehicle) {
    selectedVehicle = vehicle;
    emit(ApplyChanged());
  }

  void setGender(String? value) {
    gender = value;
    emit(ApplyChanged());
  }

  Future<void> applyDriver() async {
    emit(ApplyLoading());

    try {
      final countryName = (selectedCountry as Country).name;
      final vehicleId = selectedVehicle?.id ?? '';
      final selectedGender = gender ?? 'Male';

      await _applyDriverUseCase(
        country: countryName,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        vehicleType: vehicleId,
        vehicleNumber: vehicleNumberController.text.trim(),
        vehicleLicensePath: vehicleLicensePath ?? '',
        nid: nidController.text.trim(),
        nidImgPath: nidImagePath ?? '',
        email: emailController.text.trim(),
        password: passwordController.text,
        rePassword: rePasswordController.text,
        gender: selectedGender,
        phone: phoneController.text.trim(),
      );

      emit(ApplySuccess("Application submitted successfully"));
    } catch (e) {
      emit(ApplyError("$e"));
    }
  }

  Future<void> loadVehicles() async {
    emit(ApplyLoading());
    try {
      final response = await _getVehiclesUseCase();
      vehicles = response;
      if (vehicles.isNotEmpty) {
        selectedVehicle = vehicles.first;
      }
      emit(ApplyChanged());
    } catch (e) {
      emit(ApplyError("Failed to load vehicles: $e"));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    vehicleNumberController.dispose();
    vehicleLicenseController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nidController.dispose();
    nidImgController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    return super.close();
  }
}
