import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_response.dart';
import 'package:tarcking_app/features/auth/domain/repo/auth_repo.dart';
import 'package:tarcking_app/features/auth/domain/responses/auth_response.dart';

@injectable
class LoginUsecase {
  final AuthRepo authRepo;

  LoginUsecase(this.authRepo);

  Future<AuthResponse<LoginResponse>> invoke(LoginRequest loginRequest) async {
    return authRepo.login(loginRequest);
  }
}
