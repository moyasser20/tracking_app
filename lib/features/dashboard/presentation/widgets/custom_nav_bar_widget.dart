import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildNavBarItem(AppIcons.homeIcon, local.home, 0, context),
          ),
          Expanded(
            child: _buildNavBarItem(
              AppIcons.ordersIcon,
              local.orders,
              1,
              context,
            ),
          ),
          Expanded(
            child: _buildNavBarItem(
              AppIcons.profileIcon,
              local.profile,
              2,
              context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(
    String icon,
    String label,
    int index,
    BuildContext context,
  ) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 20,
            width: 20,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.pink : AppColors.grey,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: isSelected ? AppColors.pink : AppColors.grey,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
