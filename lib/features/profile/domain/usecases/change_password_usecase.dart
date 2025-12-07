import 'package:injectable/injectable.dart';

import '../../data/models/change_password_request_model.dart';
import '../../data/models/change_password_response_model.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class ChangePasswordUseCases {
  final ProfileRepository _profileRepository;

  ChangePasswordUseCases(this._profileRepository);

  Future<ChangePasswordResponseModel> call(ChangePasswordRequestModel request) {
    return _profileRepository.changePassword(request);
  }
}
