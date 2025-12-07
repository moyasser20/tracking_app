import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tarcking_app/core/common/widgets/custom_snackbar_widget.dart';
import 'package:tarcking_app/core/contants/countries.dart';
import 'package:tarcking_app/core/extensions/countryes_flages.dart';
import 'package:tarcking_app/core/widgets/custom_elevated_button.dart';
import 'package:tarcking_app/core/widgets/custom_drobdown_country_filed.dart';
import 'package:tarcking_app/core/widgets/custom_text_field.dart';
import 'package:tarcking_app/core/widgets/coustom_app_bar.dart';
import '../../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/apply_entites/vehicle_enitity.dart';
import '../view_model/apply_cubit.dart';

class ApplyScreen extends StatelessWidget {
  const ApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => GetIt.I<ApplyCubit>()..loadVehicles(),
      child: BlocListener<ApplyCubit, ApplyState>(
        listener: (context, state) {
          if (state is ApplySuccess) {
            showCustomSnackBar(context, state.message, isError: false);
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.applicationApproved,
            );
          } else if (state is ApplyError) {
            showCustomSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            final cubit = context.read<ApplyCubit>();

            if (state is ApplyLoading) {
              return const Scaffold(
                backgroundColor: AppColors.white,
                body: AppLoadingIndicator(),
              );
            }

            return Scaffold(
              backgroundColor: AppColors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CoustomAppBar(title: local.applyTitle),
                        const SizedBox(height: 25.0),
                        Text(
                          local.welcome,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          local.joinTeam,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            color: Colors.blueGrey,
                          ),
                        ),
                        Form(
                          key: cubit.formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Column(
                              spacing: 20,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDropdownField<Country>(
                                  label: local.country,
                                  value: cubit.selectedCountry,
                                  items: Countries.countryes,
                                  itemLabel:
                                      (country) =>
                                          "${country.code.toFlag} ${country.name}",
                                  onChanged: cubit.setCountry,
                                ),
                                CustomTextFormField(
                                  label: local.firstLegalName,
                                  hint: local.firstLegalNameHint,
                                  controller: cubit.firstNameController,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return local.firstNameRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  label: local.secondLegalName,
                                  hint: local.secondLegalNameHint,
                                  controller: cubit.lastNameController,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return local.secondNameRequired;
                                    }
                                    return null;
                                  },
                                ),
                                if (cubit.vehicles.isNotEmpty)
                                  CustomDropdownField<VehicleEntity>(
                                    label: local.vehicleType,
                                    value:
                                        cubit.selectedVehicle ??
                                        cubit.vehicles.first,
                                    items: cubit.vehicles,
                                    itemLabel: (v) => v.type ?? '',
                                    onChanged: cubit.setVehicleType,
                                  )
                                else
                                  Text(local.noVehiclesAvailable),
                                CustomTextFormField(
                                  label: local.vehicleNumber,
                                  hint: local.vehicleNumberHint,
                                  controller: cubit.vehicleNumberController,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return local.vehicleNumberRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  showUploadIcon: true,
                                  label: local.vehicleLicense,
                                  hint: local.vehicleLicenseHint,
                                  controller: cubit.vehicleLicenseController,
                                  readonly: true,
                                  onPressed: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(type: FileType.image);
                                    if (result != null &&
                                        result.files.single.path != null) {
                                      cubit.setVehicleLicensePath(
                                        result.files.single.path,
                                      );
                                    }
                                  },
                                  validator: (v) {
                                    if ((cubit.vehicleLicensePath ?? '')
                                        .isEmpty) {
                                      return local.vehicleLicenseRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  label: local.email,
                                  hint: local.emailHint,
                                  controller: cubit.emailController,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return local.emailRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  label: local.phoneNumber,
                                  hint: local.phoneHint,
                                  controller: cubit.phoneController,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return local.phoneRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  label: local.idNumber,
                                  hint: local.idNumberHint,
                                  controller: cubit.nidController,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return local.idNumberRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  showUploadIcon: true,
                                  label: local.idImage,
                                  hint: local.idImageHint,
                                  controller: cubit.nidImgController,
                                  readonly: true,
                                  onPressed: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(type: FileType.image);
                                    if (result != null &&
                                        result.files.single.path != null) {
                                      cubit.setNidImagePath(
                                        result.files.single.path,
                                      );
                                    }
                                  },
                                  validator: (v) {
                                    if ((cubit.nidImagePath ?? '').isEmpty) {
                                      return local.idImageRequired;
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: local.password,
                                        hint: local.passwordHint,
                                        controller: cubit.passwordController,
                                        obscureText: true,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return local.passwordRequired;
                                          }
                                          if (v.length < 8) {
                                            return local.passwordMinChars;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: local.confirmPassword,
                                        hint: local.confirmPasswordHint,
                                        controller: cubit.rePasswordController,
                                        obscureText: true,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return local
                                                .confirmPasswordRequired;
                                          }
                                          if (v !=
                                              cubit.passwordController.text) {
                                            return local.passwordsDoNotMatch;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.gender,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'female',
                                          groupValue: cubit.gender,
                                          onChanged: cubit.setGender,
                                        ),
                                        Text(local.female),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'male',
                                          groupValue: cubit.gender,
                                          onChanged: cubit.setGender,
                                        ),
                                        Text(local.male),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: local.continueBtn,
                            isLoading: state is ApplyLoading,
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.applyDriver();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
