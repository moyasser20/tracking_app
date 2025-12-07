import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:tarcking_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:tarcking_app/features/profile/domain/usecases/edit_profile_data_usecase.dart';
import 'package:tarcking_app/features/profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:tarcking_app/features/profile/domain/usecases/upload_photo_usecase.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';

// Generate mocks for the classes we need
@GenerateMocks([
  GetProfileDataUseCase,
  EditProfileDataUseCase,
  UploadPhotoUseCase,
  ProfileRepository,
  ProfileViewModel,
], customMocks: [])
// Mock File class for testing photo upload functionality
class MockFile extends Mock implements File {}
