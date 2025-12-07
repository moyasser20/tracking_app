import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/auth/domain/repo/auth_repo.dart';

@injectable
class LogoutUseCase {
  final AuthRepo _authRepo;
  LogoutUseCase(this._authRepo);

  Future<String> call() async {
    return await _authRepo.logout();
  }
}
