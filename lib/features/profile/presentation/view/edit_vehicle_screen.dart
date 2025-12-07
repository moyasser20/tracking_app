import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../core/Widgets/custom_text_field.dart';
import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_drobdown_country_filed.dart';
import '../../../auth/domain/entities/apply_entites/vehicle_enitity.dart';
import '../../domain/entity/user_entity.dart';
import '../viewmodel/edit_vehicle_viewmodel.dart';
import '../viewmodel/states/edit_vehicle_states.dart';

class EditVehicleScreen extends StatefulWidget {
  final UserEntity vehicle;
  const EditVehicleScreen({super.key, required this.vehicle});

  @override
  State<EditVehicleScreen> createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => GetIt.I<EditVehicleViewModel>()..loadVehicles(),
      child: BlocBuilder<EditVehicleViewModel, EditVehicleStates>(
        builder: (context, state) {
          final cubit = context.read<EditVehicleViewModel>();
          if (state is EditVehicleLoadingState) {
            return const Scaffold(
              backgroundColor: AppColors.white,
              body: AppLoadingIndicator(),
            );
          } else if (state is EditVehicleErrorState) {
            showCustomSnackBar(context, state.message, isError: true);
          } else if (state is EditVehicleSuccessState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.white,
                title: Text(
                  local.profileTitle,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  iconSize: 24,
                  icon: Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () {
                    Navigator.pop(context, isEdit);
                  },
                ),
              ),
              body: Form(
                key: cubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    spacing: 25,
                    children: [
                      if (cubit.vehicles.isNotEmpty)
                        CustomDropdownField<VehicleEntity>(
                          label: local.vehicleType,
                          value: cubit.selectedVehicle ?? cubit.vehicles.first,
                          items: cubit.vehicles,
                          itemLabel: (v) => v.type,
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
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          if (result != null &&
                              result.files.single.path != null) {
                            cubit.setVehicleLicensePath(
                              result.files.single.path,
                            );
                          }
                        },
                        validator: (v) {
                          if ((cubit.vehicleLicensePath ?? '').isEmpty) {
                            return local.vehicleLicenseRequired;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: local.updateButton,
                          onPressed: () {
                            showCustomSnackBar(
                              context,
                              "Data updated successfully",
                              isError: false,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Scaffold(backgroundColor: AppColors.white);
        },
      ),
    );
  }
}
