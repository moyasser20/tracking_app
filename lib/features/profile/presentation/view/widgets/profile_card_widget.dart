import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/user_entity.dart';
import '../../viewmodel/profile_viewmodel.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.profile,
    required this.theme,
  });

  final UserEntity profile;
  final ThemeData theme;

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
      child: GestureDetector(
        onTap: () async {
          final updated = await Navigator.pushNamed(
            context,
            AppRoutes.editProfile,
            arguments: profile,
          );
          if (updated == true) {
            context.read<ProfileViewModel>().clearProfileCache();
            context.read<ProfileViewModel>().getProfile();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(profile.photo),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${profile.firstName} ${profile.lastName}",
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.phone,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
