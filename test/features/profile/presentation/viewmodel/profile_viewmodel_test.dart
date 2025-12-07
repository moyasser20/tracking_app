import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/core/errors/api_result.dart';
import 'package:tarcking_app/features/profile/domain/entity/user_entity.dart';
import 'package:tarcking_app/features/profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/states/profile_states.dart';

// Manual mock for GetProfileDataUseCase
class MockGetProfileDataUseCase extends Mock implements GetProfileDataUseCase {
  @override
  Future<ApiResult<UserEntity>> call() => super.noSuchMethod(
    Invocation.method(#call, []),
    returnValue: Future.value(
      ApiSuccessResult<UserEntity>(
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
  );
}

void main() {
  late ProfileViewModel viewModel;
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;
  late UserEntity testUser;

  setUp(() {
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    viewModel = ProfileViewModel(mockGetProfileDataUseCase);

    testUser = UserEntity(
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
  });

  group('ProfileViewModel', () {
    test('initial state should be ProfileInitialState', () {
      expect(viewModel.state, isA<ProfileInitialState>());
    });

    group('getProfile', () {
      test(
        'should emit ProfileSuccessState when usecase returns success',
        () async {
          // Arrange
          when(
            mockGetProfileDataUseCase(),
          ).thenAnswer((_) async => ApiSuccessResult(testUser));

          // Act
          await viewModel.getProfile();

          // Assert
          verify(mockGetProfileDataUseCase()).called(1);
          expect(viewModel.state, isA<ProfileSuccessState>());
          expect(
            (viewModel.state as ProfileSuccessState).user,
            equals(testUser),
          );
        },
      );

      test(
        'should emit ProfileErrorState when usecase returns error',
        () async {
          // Arrange
          const errorMessage = 'Network error';
          when(
            mockGetProfileDataUseCase(),
          ).thenAnswer((_) async => ApiErrorResult(errorMessage));

          // Act
          await viewModel.getProfile();

          // Assert
          verify(mockGetProfileDataUseCase()).called(1);
          expect(viewModel.state, isA<ProfileErrorState>());
          expect(
            (viewModel.state as ProfileErrorState).message,
            equals(errorMessage),
          );
        },
      );
    });

    test('should not call usecase when already loading', () async {
      // Arrange - Simulate loading state
      viewModel.emit(ProfileLoadingState());

      // Act
      await viewModel.getProfile();

      // Assert
      verifyNever(mockGetProfileDataUseCase());
      expect(viewModel.state, isA<ProfileLoadingState>());
    });

    test('clearProfileCache should reset state', () {
      // Act
      viewModel.clearProfileCache();

      // Assert
      expect(viewModel.state, isA<ProfileInitialState>());
    });
  });
}
