import 'package:flutter/material.dart';
import 'package:tarcking_app/core/contants/app_icons.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../homescreen/presentation/widgets/address_widget.dart';

class MyOrderContainerWidget extends StatelessWidget {
  final String orderState;
  final String orderNumber;
  final String storeName;
  final String storeAddress;
  final String storeImage;
  final String userName;
  final String userImage;
  final String userAddress;
  final int fallbackIndex;
  final Color? stateColor;

  const MyOrderContainerWidget({
    super.key,
    required this.orderState,
    required this.orderNumber,
    required this.storeName,
    required this.storeAddress,
    required this.storeImage,
    required this.userName,
    required this.userImage,
    required this.userAddress,
    required this.fallbackIndex,
    this.stateColor,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final state = orderState.toLowerCase().trim();

    String icon;
    Color color;

    if (stateColor != null) {
      color = stateColor!;
      if (color == AppColors.green) {
        icon = AppIcons.acceptedIcon;
      } else if (color == AppColors.red) {
        icon = AppIcons.cancelledIcon;
      } else {
        icon = AppIcons.inProgressIcon;
      }
    } else if (state.contains("complete")) {
      icon = AppIcons.acceptedIcon;
      color = AppColors.green;
    } else if (state.contains("cancel")) {
      icon = AppIcons.cancelledIcon;
      color = AppColors.red;
    } else if (state.contains("progress") || state.contains("pending")) {
      icon = AppIcons.inProgressIcon;
      color = Colors.orange;
    } else {
      icon = AppIcons.inProgressIcon;
      color = AppColors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                local.flowerOrder,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontFamily: "Inter",
                ),
              ),
              Text(
                orderNumber,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Order status row
          Row(
            children: [
              Image.asset(
                icon,
                height: 20,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                orderState,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ).setHorizontalPadding(context, 0.02),

          const SizedBox(height: 20),

          AddressWidget(
            titleAddress: local.pickupAddress,
            image: storeImage,
            storeName: storeName,
            address: storeAddress,
            fallbackIndex: fallbackIndex,
          ),

          const SizedBox(height: 20),

          AddressWidget(
            titleAddress: local.userAddress,
            image: userImage,
            storeName: userName,
            address: userAddress,
            fallbackIndex: fallbackIndex + 1,
          ),
        ],
      ),
    ).setHorizontalPadding(context, 0.015);
  }
}
