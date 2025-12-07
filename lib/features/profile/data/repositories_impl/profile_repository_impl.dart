import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:tarcking_app/features/profile/data/datasource/profile_remote_datasource.dart';
import '../../../../core/errors/api_result.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/change_password_request_model.dart';
import '../models/change_password_response_model.dart';
import '../models/edit_profile_request_model.dart';
import '../models/edit_profile_response_model.dart';
import '../models/upload_photo_response.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _remoteDatasource;

  ProfileRepositoryImpl(this._remoteDatasource);

  @override
  Future<ApiResult<UserEntity>> getProfile() async {
    final result = await _remoteDatasource.getProfile();

    return switch (result) {
      ApiSuccessResult(:final data) => ApiSuccessResult(
        UserEntity(
          id: data.driver.id ?? '',
          firstName: data.driver.firstName ?? '',
          lastName: data.driver.lastName ?? '',
          email: data.driver.email ?? '',
          gender: data.driver.gender ?? '',
          phone: data.driver.phone ?? '',
          photo: data.driver.photo ?? '',
          role: data.driver.role ?? '',
          vehicleType: data.driver.vehicleType ?? '',
          vehicleNumber: data.driver.vehicleNumber ?? '',
          vehicleLicense: data.driver.vehicleLicense ?? '',
          nid: data.driver.nid ?? '',
          nidImg: data.driver.nidImg ?? '',
        ),
      ),
      ApiErrorResult(:final errorMessage) => ApiErrorResult(errorMessage),
    };
  }

  @override
  Future<ChangePasswordResponseModel> changePassword(
    ChangePasswordRequestModel changePasswordRequestModel,
  ) {
    return _remoteDatasource.changePassword(changePasswordRequestModel);
  }

  @override
  Future<ApiResult<EditProfileResponseModel>> editProfile(
    EditProfileRequestModel model,
  ) async {
    final result = await _remoteDatasource.editProfile(model);
    return switch (result) {
      ApiSuccessResult(:final data) => ApiSuccessResult(data),
      ApiErrorResult(:final errorMessage) => ApiErrorResult(errorMessage),
    };
  }

  @override
  Future<ApiResult<UploadPhotoResponse>> uploadPhoto(File photo) {
    return _remoteDatasource.uploadPhoto(photo);
  }
}
