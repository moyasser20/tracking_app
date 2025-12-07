import 'package:injectable/injectable.dart';

import '../../entities/apply_entites/vehicle_enitity.dart';
import '../../repo/auth_repo.dart';

@lazySingleton
class GetVehiclesUseCase {
  final AuthRepo _repository;

  GetVehiclesUseCase(this._repository);

  Future<List<VehicleEntity>> call() async {
    return await _repository.getVehicles();
  }
}
