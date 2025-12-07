sealed class EditVehicleStates {}

class EditVehicleInitialState extends EditVehicleStates {}

class EditVehicleLoadingState extends EditVehicleStates {}

class EditVehicleChangedState extends EditVehicleStates {}

class EditVehicleSuccessState extends EditVehicleStates {
  final String message;
  EditVehicleSuccessState({required this.message});
}

class EditVehicleErrorState extends EditVehicleStates {
  final String message;
  EditVehicleErrorState({required this.message});
}
