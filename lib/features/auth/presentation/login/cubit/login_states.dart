sealed class LoginStates {}

final class LoginInitialState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {}

final class LoginErrorState extends LoginStates {
  final String errorMessage;
  LoginErrorState({required this.errorMessage});
}

final class ChangeRememberMeState extends LoginStates {}
