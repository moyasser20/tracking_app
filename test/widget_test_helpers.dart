import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:tarcking_app/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:tarcking_app/core/api/client/api_client.dart';

// Generate mocks
@GenerateMocks([
  ForgetPasswordUseCase,
  VerifyCodeUseCase,
  ApiClient,
  NavigatorObserver,
])
Null get any => anyNamed('any');
Null get anyString => anyNamed('String');
Null get anyResetRequest => anyNamed('ResetPasswordRequestModel');

Widget createWidgetUnderTest(Widget child) {
  return MaterialApp(home: child);
}

extension WidgetTesterExtensions on WidgetTester {
  Future<void> pumpWidgetWithScaffold(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }

  Future<void> enterTextIntoFinder(Finder finder, String text) async {
    await tap(finder);
    await enterText(finder, text);
    await pump();
  }
}
