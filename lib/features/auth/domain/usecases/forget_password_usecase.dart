import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/auth/domain/responses/auth_response.dart';
import '../repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<AuthResponse<String>> call(String email) {
    return _authRepo.forgetPassword(email);
  }
}
