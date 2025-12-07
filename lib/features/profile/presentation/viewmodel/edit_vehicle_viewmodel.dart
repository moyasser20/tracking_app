import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/states/edit_vehicle_states.dart';
import '../../../auth/domain/entities/apply_entites/vehicle_enitity.dart';
import '../../../auth/domain/usecases/apply/vehicle_usecase.dart';
import '../../domain/usecases/edit_profile_data_usecase.dart';

@injectable
class EditVehicleViewModel extends Cubit<EditVehicleStates> {
  final EditProfileDataUseCase _editVehicleUseCase;
  final GetVehiclesUseCase _getVehiclesUseCase;

  EditVehicleViewModel(this._editVehicleUseCase, this._getVehiclesUseCase)
    : super(EditVehicleInitialState());

  final formKey = GlobalKey<FormState>();

  final vehicleNumberController = TextEditingController();
  final vehicleLicenseController = TextEditingController();

  List<VehicleEntity> vehicles = [];
  VehicleEntity? selectedVehicle;
  String? vehicleLicensePath;

  void setVehicleType(VehicleEntity? vehicle) {
    selectedVehicle = vehicle;
    emit(EditVehicleSuccessState(message: "vehicle changed successfully"));
  }

  void setVehicleLicensePath(String? path) {
    vehicleLicensePath = path;
    if (path != null) {
      vehicleLicenseController.text = path.split('/').last;
    }
    emit(EditVehicleSuccessState(message: ""));
  }

  Future<void> loadVehicles() async {
    emit(EditVehicleLoadingState());
    try {
      final response = await _getVehiclesUseCase();
      vehicles = response;
      if (vehicles.isNotEmpty) {
        selectedVehicle = vehicles.first;
      }
      emit(EditVehicleSuccessState(message: "vehicle loaded successfully"));
    } catch (e) {
      emit(EditVehicleErrorState(message: 'Failed to load vehicles: $e'));
    }
  }

  // Future<void> submitVehicleUpdate() async {
  //   emit(EditVehicleLoadingState());
  //   final request = EditProfileRequestModel(
  //     vehicleType: selectedVehicle?.id ?? '',
  //     vehicleNumber: vehicleNumberController.text.trim(),
  //     vehicleLicensePath: vehicleLicensePath ?? '',
  //   );
  //   final response = await _editVehicleUseCase(request);
  //   if (response is ApiSuccessResult<EditProfileRequestModel>) {
  //     emit(EditVehicleSuccessState(message: response.data.message));
  //   } else if (response is ApiErrorResult<EditProfileRequestModel>) {
  //     emit(EditVehicleErrorState(message: response.errorMessage));
  //   } else {
  //     emit(EditVehicleErrorState(message: 'Unexpected error'));
  //   }
  // }
}
