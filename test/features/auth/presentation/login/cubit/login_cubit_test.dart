import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/domain/responses/auth_response.dart';
import 'package:tarcking_app/features/auth/domain/usecases/login_usecase/login_usecase.dart';
import 'package:tarcking_app/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:tarcking_app/features/auth/presentation/login/cubit/login_states.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class FakeLoginRequest extends Fake implements LoginRequest {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginUsecase mockLoginUsecase;

  setUpAll(() {
    registerFallbackValue(FakeLoginRequest());
  });

  const email = "test@example.com";
  const password = "123456";

  group("LoginCubit Success Tests", () {
    blocTest<LoginCubit, LoginStates>(
      "emits [LoginLoadingState, LoginErrorState] when login fails",
      build: () {
        mockLoginUsecase = MockLoginUsecase();
        when(
          () => mockLoginUsecase.invoke(any()),
        ).thenAnswer((_) async => AuthResponse.error("Invalid credentials"));
        return LoginCubit(loginUsecase: mockLoginUsecase);
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect:
          () => [
            isA<LoginLoadingState>(),
            isA<LoginErrorState>().having(
              (s) => s.errorMessage,
              "errorMessage",
              "Invalid credentials",
            ),
          ],
    );

    test("toggleRememberMe changes state correctly", () {
      mockLoginUsecase = MockLoginUsecase();
      final cubit = LoginCubit(loginUsecase: mockLoginUsecase);

      expectLater(cubit.stream, emitsInOrder([isA<ChangeRememberMeState>()]));

      cubit.toggleRememberMe(true);
      expect(cubit.rememberMe, true);

      cubit.close();
    });
  });
}
