import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/domain/services/auth_services.dart';
import 'package:tarcking_app/features/auth/domain/usecases/login_usecase/login_usecase.dart';
import 'package:tarcking_app/features/auth/presentation/login/cubit/login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUsecase loginUsecase;

  LoginCubit({required this.loginUsecase}) : super(LoginInitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  void toggleRememberMe(bool boxValue) {
    rememberMe = boxValue;
    emit(ChangeRememberMeState());
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    final request = LoginRequest(
      email: email.trim(),
      password: password.trim(),
    );

    final response = await loginUsecase.invoke(request);
    if (response.data?.token != null && response.data!.token!.isNotEmpty) {
      await AuthService.saveAuthToken(response.data?.token ?? "");
      if (rememberMe) {
        await AuthService.saveRememberMe(rememberMe);
      }
      emit(LoginSuccessState());
    } else {
      if (response.error != null) {
        emit(LoginErrorState(errorMessage: response.error!));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
