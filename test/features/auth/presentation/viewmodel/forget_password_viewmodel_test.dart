import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tarcking_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/viewmodel/forget_password_viewmodel.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/viewmodel/states/forget_password_states.dart';

import '../../../../../test/widget_test_helpers.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late ForgetPasswordCubit cubit;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    cubit = ForgetPasswordCubit(mockForgetPasswordUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit', () {
    test('initial state is ForgetPasswordInitialState', () {
      expect(cubit.state, isA<ForgetPasswordInitialState>());
    });

    group('validateEmailField', () {
      test('sets isFormValid to false for invalid email', () {
        // Arrange
        cubit.emailController.text = 'invalid-email';

        // Act
        cubit.validateEmailField();

        // Assert
        expect(cubit.isFormValid, false);
      });

      test('sets isFormValid to true for valid email', () {
        // Arrange
        cubit.emailController.text = 'test@example.com';

        // Act
        cubit.validateEmailField();

        // Assert
        expect(cubit.isFormValid, true);
      });

      test('emits state when isFormValid changes', () {
        // Arrange
        var emittedStates = [];
        final subscription = cubit.stream.listen((state) {
          emittedStates.add(state);
        });

        // Act - change from invalid to valid
        cubit.emailController.text = 'test@example.com';
        cubit.validateEmailField();

        // Assert
        expect(emittedStates.length, 0);

        subscription.cancel();
      });
    });
  });
}
