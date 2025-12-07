import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../l10n/translation/app_localizations.dart';

class LocalizedOrderState {
  final String label;
  final Color color;

  const LocalizedOrderState(this.label, this.color);
}

LocalizedOrderState getLocalizedOrderState(BuildContext context, String state) {
  final local = AppLocalizations.of(context)!;
  final normalized = state.toLowerCase().replaceAll(" ", "");

  switch (normalized) {
    case "completed":
      return LocalizedOrderState(local.completedStatus, AppColors.green);
    case "cancelled":
    case "canceled":
      return LocalizedOrderState(local.cancelledStatus, AppColors.red);
    case "inprogress":
      return LocalizedOrderState(local.inProgressStatus, Colors.orange);
    case "pending":
      return LocalizedOrderState(local.pendingStatus, Colors.orangeAccent);
    default:
      return LocalizedOrderState(local.unknownStatus, Colors.grey);
  }
}
