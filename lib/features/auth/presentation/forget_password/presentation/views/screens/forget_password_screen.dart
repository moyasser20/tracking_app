import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import '../../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../../../../core/extensions/validations.dart';
import '../../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../../core/routes/route_names.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../viewmodel/forget_password_viewmodel.dart';
import '../../viewmodel/states/forget_password_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late ForgetPasswordCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<ForgetPasswordCubit>();
    _cubit.emailController.addListener(() {
      _cubit.validateEmailField();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Safe localization access
    final local = AppLocalizations.of(context);

    // If localization is not available, show loading or default text
    if (local == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          local.password,
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        builder: (context, state) {
          final cubit = context.watch<ForgetPasswordCubit>();
          return Form(
            key: _formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  local.forgetPassword,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  local.forgetPasswordUnderText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomTextFormField(
                  controller: cubit.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return local.requiredEmailErrorMessage;
                    }
                    if (!Validations.validateEmail(value)) {
                      return local.validationEmailErrorMessage;
                    }
                    return null;
                  },
                  label: local.emailLabel,
                  hint: local.emailHintText,
                ),
                const SizedBox(height: 50),
                state is ForgetPasswordLoadingState
                    ? SizedBox(
                      height: 50,
                      width: 50,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScalePulseOut,
                        colors: [AppColors.pink],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                      ),
                    )
                    : CustomElevatedButton(
                      text: local.continueButton,
                      onPressed:
                          cubit.isFormValid
                              ? () {
                                if (_formState.currentState!.validate()) {
                                  cubit.sendResetCode();
                                }
                              }
                              : null,
                      color: cubit.isFormValid ? AppColors.pink : Colors.grey,
                    ),
              ],
            ).setHorizontalAndVerticalPadding(context, 0.055, 0.05),
          );
        },
        listener: (context, state) {
          if (!mounted) return;

          if (state is ForgetPasswordSuccessState) {
            Navigator.pushNamed(
              context,
              arguments: _cubit.emailController.text,
              AppRoutes.emailVerification,
            );
          } else if (state is ForgetPasswordErrorState) {
            showCustomSnackBar(context, state.message, isError: true);
          }
        },
      ),
    );
  }
}
