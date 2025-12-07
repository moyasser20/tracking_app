import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarcking_app/core/widgets/custom_Elevated_Button.dart';
import 'package:tarcking_app/core/l10n/translation/app_localizations.dart';
import 'package:tarcking_app/features/onboarding/presentation/view/onboarding_screen.dart';

Widget makeTestableWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}

void main() {
  group('OnBoardingScreen Widget Tests (with Keys)', () {
    testWidgets('renders onboarding image', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(const OnBoardingScreen()));

      expect(find.byKey(const Key('onboardingImage')), findsOneWidget);
    });

    testWidgets('shows welcome and app name texts', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(const OnBoardingScreen()));

      expect(find.byKey(const Key('welcomeText')), findsOneWidget);
      expect(find.byKey(const Key('appNameText')), findsOneWidget);
    });

    testWidgets('has two main buttons (login + apply now)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(const OnBoardingScreen()));

      expect(find.byKey(const Key('loginButton')), findsOneWidget);
      expect(find.byKey(const Key('applyNowButton')), findsOneWidget);

      final buttons = find.byType(CustomElevatedButton);
      expect(buttons, findsNWidgets(2));
    });

    testWidgets('shows version text', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(const OnBoardingScreen()));

      expect(find.byKey(const Key('versionText')), findsOneWidget);
    });

  });
}
