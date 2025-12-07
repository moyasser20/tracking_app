import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/core/errors/api_result.dart';
import 'package:tarcking_app/features/profile/data/models/edit_profile_response_model.dart';
import 'package:tarcking_app/features/profile/data/models/upload_photo_response.dart';
import 'package:tarcking_app/features/profile/data/models/user_model.dart';
import 'package:tarcking_app/features/profile/domain/entity/user_entity.dart';
import 'package:tarcking_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:tarcking_app/features/profile/domain/usecases/edit_profile_data_usecase.dart';
import 'package:tarcking_app/features/profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:tarcking_app/features/profile/domain/usecases/upload_photo_usecase.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/edit_profile_viewmodel.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/states/edit_profile_states.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/states/profile_states.dart';
import 'package:tarcking_app/features/logout/viewmodel/logout_viewmodel.dart';
import 'package:tarcking_app/features/localization/localization_controller/localization_cubit.dart';

// Manual mocks for all required classes
class MockGetProfileDataUseCase extends Mock implements GetProfileDataUseCase {
  @override
  Future<ApiResult<UserEntity>> call() =>
      super.noSuchMethod(
            Invocation.method(#call, []),
            returnValue: Future.value(
              ApiSuccessResult(
                UserEntity(
                  id: '',
                  firstName: '',
                  lastName: '',
                  email: '',
                  gender: '',
                  phone: '',
                  photo: '',
                  role: '',
                  vehicleType: '',
                  vehicleNumber: '',
                  vehicleLicense: '',
                  nid: '',
                  nidImg: '',
                ),
              ),
            ),
            returnValueForMissingStub: Future.value(
              ApiSuccessResult(
                UserEntity(
                  id: '',
                  firstName: '',
                  lastName: '',
                  email: '',
                  gender: '',
                  phone: '',
                  photo: '',
                  role: '',
                  vehicleType: '',
                  vehicleNumber: '',
                  vehicleLicense: '',
                  nid: '',
                  nidImg: '',
                ),
              ),
            ),
          )
          as Future<ApiResult<UserEntity>>;
}

class MockEditProfileDataUseCase extends Mock
    implements EditProfileDataUseCase {}

class MockUploadPhotoUseCase extends Mock implements UploadPhotoUseCase {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockFile extends Mock implements File {}

// Mock view models
class MockProfileViewModel extends Mock implements ProfileViewModel {
  @override
  ProfileStates state = ProfileInitialState();

  @override
  Stream<ProfileStates> get stream => Stream.value(state);

  @override
  void emit(ProfileStates state) {
    this.state = state;
  }
}

class MockEditProfileViewModel extends Mock implements EditProfileViewModel {
  @override
  EditProfileStates state = EditProfileInitialState();

  @override
  Stream<EditProfileStates> get stream => Stream.value(state);

  @override
  void emit(EditProfileStates state) {
    this.state = state;
  }

  @override
  final TextEditingController firstnameController = TextEditingController();

  @override
  final TextEditingController lastnameController = TextEditingController();

  @override
  final TextEditingController emailController = TextEditingController();

  @override
  final TextEditingController phoneController = TextEditingController();
}

// Helper functions to create test data
UserEntity createMockUserEntity() {
  return UserEntity(
    id: '123',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    gender: 'male',
    phone: '1234567890',
    photo: 'https://example.com/photo.jpg',
    role: 'driver',
    vehicleType: '',
    vehicleNumber: '',
    vehicleLicense: '',
    nid: '',
    nidImg: '',
  );
}

// Mock edit profile response for testing
EditProfileResponseModel createMockEditProfileResponse() {
  return EditProfileResponseModel(
    message: 'Profile updated successfully',
    driver: User(
      id: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      gender: 'male',
      phone: '1234567890',
      photo: 'https://example.com/photo.jpg',
      role: 'driver',
    ),
  );
}

// Mock upload photo response for testing
UploadPhotoResponse createMockUploadPhotoResponse() {
  return UploadPhotoResponse(message: 'Photo uploaded successfully');
}

// Additional mock classes for testing
class MockLogoutViewModel extends Mock implements LogoutViewModel {}

class MockLocalizationCubit extends Mock implements LocalizationCubit {}
