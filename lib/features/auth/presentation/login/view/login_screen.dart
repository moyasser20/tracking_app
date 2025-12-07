import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/common/widgets/custom_snackbar_widget.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/core/extensions/validations.dart';
import 'package:tarcking_app/core/theme/app_colors.dart';
import 'package:tarcking_app/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:tarcking_app/features/auth/presentation/login/cubit/login_states.dart';
import '../../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = context.read<LoginCubit>();
    _loginCubit.emailController.addListener(_updateButtonState);
    _loginCubit.passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _loginCubit.emailController.removeListener(_updateButtonState);
    _loginCubit.passwordController.removeListener(_updateButtonState);
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled =
          _loginCubit.emailController.text.isNotEmpty &&
          _loginCubit.passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    local.login,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                    ),
                  ).setHorizontalAndVerticalPadding(context, 0.04, 0.05),
                ],
              ),
              CustomTextFormField(
                controller: _loginCubit.emailController,
                label: local.emailLabel,
                hint: local.emailHintText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return local.emailIsEmptyErrorMessage;
                  }
                  if (!Validations.validateEmail(value)) {
                    return local.emailValidationErrorMsg;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                controller: _loginCubit.passwordController,
                label: local.passwordLabel,
                hint: local.passwordHintText,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return local.passwordRequiredErrorMsg;
                  }
                  if (!Validations.validatePassword(value)) {
                    return local.passwordValidationErrorMsg;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.pink,
                    checkColor: AppColors.white,
                    value: _loginCubit.rememberMe,
                    onChanged: (value) {
                      _loginCubit.toggleRememberMe(value ?? false);
                      setState(() {});
                    },
                  ),
                  Text(
                    local.rememberMe,
                    style: const TextStyle(color: AppColors.black),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.forgetPassword);
                    },
                    child: Text(
                      local.forgetPasswordTextButton,
                      style: TextStyle(
                        color: AppColors.black.withValues(alpha: 0.5),
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    showCustomSnackBar(
                      context,
                      "logged in successfully",
                      isError: false,
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashboard,
                      (route) => false,
                    );
                  } else if (state is LoginErrorState) {
                    showCustomSnackBar(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    text: local.continueButton,
                    isLoading: state is LoginLoadingState,
                    color: _isButtonEnabled ? AppColors.pink : AppColors.grey,
                    onPressed:
                        _isButtonEnabled
                            ? () {
                              if (_formKey.currentState!.validate()) {
                                _loginCubit.login(
                                  email: _loginCubit.emailController.text,
                                  password: _loginCubit.passwordController.text,
                                );
                              }
                            }
                            : null,
                  );
                },
              ),
            ],
          ).setHorizontalPadding(context, 0.04),
        ),
      ),
    );
  }
}
