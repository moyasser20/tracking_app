class UseCaseResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  UseCaseResult.success(this.data) : isSuccess = true, error = null;

  UseCaseResult.error(this.error) : isSuccess = false, data = null;

  bool get isError => !isSuccess;
}

class ResetPasswordRequestModel {
  final String email;
  final String newPassword;

  ResetPasswordRequestModel({required this.email, required this.newPassword});
}
