import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/features/profile/presentation/view/widgets/menu_item_widget.dart';
import 'package:tarcking_app/features/profile/presentation/view/widgets/profile_card_widget.dart';
import 'package:tarcking_app/features/profile/presentation/view/widgets/vehicle_info_widget.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import '../../../../core/config/di.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../localization/localization_controller/localization_cubit.dart';
import '../../../logout/viewmodel/logout_viewmodel.dart';
import '../../../logout/views/logout_widget.dart';
import '../viewmodel/states/profile_states.dart';
import 'edit_vehicle_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt<ProfileViewModel>()..getProfile(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          leading: IconButton(
            iconSize: 24,
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              null;
            },
          ),
          title: Text(
            local.profile,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 24),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  iconSize: 32,
                  icon: SvgPicture.asset(
                    AppIcons.notificationsIcon,
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 3,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<ProfileViewModel, ProfileStates>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOut,
                    colors: [AppColors.pink],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
            } else if (state is ProfileSuccessState) {
              final profile = state.user;

              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileCardWidget(profile: profile, theme: theme),

                    const SizedBox(height: 16),

                    GestureDetector(
                      child: VehicleInfoWidget(
                        local: local,
                        theme: theme,
                        vehicle: state.user,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    EditVehicleScreen(vehicle: state.user),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    MenuItemWidget(
                      leading: SvgPicture.asset(
                        AppIcons.translateIcon,
                        width: 24,
                        height: 24,
                      ),
                      title: local.language,
                      trailing: Text(
                        textAlign: TextAlign.left,
                        local.languageChanged,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.pink,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: AppColors.white,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  spacing: 16.0,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        local.changeLanguage,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pink,
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: AppColors.white,
                                      child: SizedBox(
                                        height: 60,
                                        width: double.infinity,
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<LocalizationCubit>()
                                                .selectLanguage("Arabic");
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  local.arabic,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Icon(
                                                  context
                                                          .read<
                                                            LocalizationCubit
                                                          >()
                                                          .isSelected("Arabic")
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons
                                                          .radio_button_unchecked,
                                                  color: Colors.pink,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: AppColors.white,
                                      child: SizedBox(
                                        height: 60,
                                        width: double.infinity,
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<LocalizationCubit>()
                                                .selectLanguage("English");
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  local.english,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Icon(
                                                  context
                                                          .read<
                                                            LocalizationCubit
                                                          >()
                                                          .isSelected("English")
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons
                                                          .radio_button_unchecked,
                                                  color: Colors.pink,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    MenuItemWidget(
                      leading: SvgPicture.asset(
                        AppIcons.logoutIcon,
                        width: 24,
                        height: 24,
                      ),
                      title: local.logout,
                      trailing: const Icon(Icons.logout, color: AppColors.pink,),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => BlocProvider(
                                create: (context) => getIt<LogoutViewModel>(),
                                child: const LogoutDialogWidget(),
                              ),
                        );
                      },
                    ),
                    const SizedBox(height: 10,),
                    const Spacer(),
                    Center(
                      child: Text(
                        local.versionInfo,
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ).setHorizontalAndVerticalPadding(context, 0.03, 0.02),
              );
            } else if (state is ProfileErrorState) {
              log(local.error);
              log(state.message);
              return SizedBox.shrink();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
