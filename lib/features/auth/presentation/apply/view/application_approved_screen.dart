import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/core/widgets/custom_Elevated_Button.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';

class ApplicationApprovedScreen extends StatelessWidget {
  const ApplicationApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.checkCircle),
              SizedBox(height: 25),
              Text(
                local.applicationSub,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                local.applicationSubMsg,
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              CustomElevatedButton(
                text: local.login,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                height: 55,
                borderRadius: 24,
              ),
            ],
          ).setHorizontalPadding(context, 0.05),
          Image.asset(AppImages.applyBackground),
        ],
      ),
    );
  }
}
