import 'package:flutter/material.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/core/theme/app_colors.dart';
import 'package:tarcking_app/core/widgets/custom_Elevated_Button.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../auth/domain/services/auth_services.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                AppImages.OnboardingImage,
                key: const Key('onboardingImage'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  local.welcomeTo,
                  key: const Key('welcomeText'),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    fontFamily: "Inter",
                  ),
                ),
              ).setHorizontalPadding(context, 0.045),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  local.floweryRiderApp,
                  key: const Key('appNameText'),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    fontFamily: "Inter",
                  ),
                ),
              ).setHorizontalPadding(context, 0.045),
              const SizedBox(height: 20),
              CustomElevatedButton(
                width: double.infinity,
                key: const Key('loginButton'),
                text: local.login,
                onPressed: () async {
                  final initialRoute = await _getInitialRoute();
                  Navigator.pushReplacementNamed(context, initialRoute);
                },
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                width: double.infinity,
                key: const Key('applyNowButton'),
                text: local.applyNow,
                borderColor: AppColors.grey.withOpacity(0.5),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.apply);
                },
                color: AppColors.white,
                textColor: AppColors.grey.withOpacity(0.8),
              ),
              const SizedBox(height: 200),
              Text(
                local.versionText,
                key: const Key('versionText'),
                style: const TextStyle(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> _getInitialRoute() async {
  final isLoggedIn = await AuthService.isUserAuthenticated();
  if (isLoggedIn) {
    return AppRoutes.dashboard;
  } else {
    await AuthService.logout();
    return AppRoutes.login;
  }
}
