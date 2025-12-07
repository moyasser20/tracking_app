import 'package:flutter/material.dart';
import 'package:tarcking_app/core/Widgets/Custom_Elevated_Button.dart';

import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 180),
            Image.asset(AppImages.successImage),
            const SizedBox(height: 30),
            Text(
              local!.thankYou,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.green,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 10),
             Text(
               textAlign: TextAlign.center,
              local.orderDeliveredSuccessfully,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.black,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 70),
            CustomElevatedButton(width : 370,text: local.done, onPressed: (){Navigator.pushNamed(context, AppRoutes.dashboard);})


          ],
        ),
      ),

    );
  }
}
