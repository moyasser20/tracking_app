import 'package:flutter/material.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/entity/vehicle_helper.dart';

class VehicleInfoWidget extends StatelessWidget {
  const VehicleInfoWidget({
    super.key,
    required this.local,
    required this.theme,
    required this.vehicle,
  });

  final AppLocalizations local;
  final ThemeData theme;
  final UserEntity vehicle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.vehicleInfo,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    VehicleHelper.getVehicleTypeById(
                      "676b64349f3884b3405c14cd",
                    )!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                vehicle.vehicleNumber,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
