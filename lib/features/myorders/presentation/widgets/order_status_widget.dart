import 'package:flutter/material.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/core/theme/app_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String ordersNumber;
  final String icon;
  final String status;
  final Color? backgroundColor;
  final Color? iconColor;

  const OrderStatusWidget({
    super.key,
    required this.ordersNumber,
    required this.icon,
    required this.status,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 85,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.lightPink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ordersNumber,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  icon,
                  height: 20,
                  //color: iconColor,
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Inter",
                    color: iconColor ?? AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).setHorizontalPadding(context, 0.01);
  }
}
