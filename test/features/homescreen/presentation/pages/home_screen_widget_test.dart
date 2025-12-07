import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tarcking_app/core/common/widgets/custome_loading_indicator.dart';
import 'package:tarcking_app/features/homescreen/presentation/view/home_screen.dart';
import 'package:tarcking_app/features/homescreen/presentation/viewmodel/home_cubit.dart';
import 'package:tarcking_app/features/homescreen/presentation/viewmodel/home_states.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

class FakeHomeState extends Fake implements HomeStates {}

void main() {
  late MockHomeCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeHomeState());
  });

  setUp(() {
    mockCubit = MockHomeCubit();
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => const Stream<HomeStates>.empty());
    when(() => mockCubit.state).thenReturn(HomeLoadingState());
  });

  Widget createTestWidget(HomeCubit cubit) {
    return MaterialApp(
      home: BlocProvider<HomeCubit>.value(
        value: cubit,
        child: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('shows loading indicator when state is HomeLoadingState', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(HomeLoadingState());
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(HomeLoadingState()));

      await tester.pumpWidget(createTestWidget(mockCubit));

      expect(find.byType(AppLoadingIndicator), findsOneWidget);
    });

    testWidgets('shows snackbar when state is HomeErrorState', (tester) async {
      when(() => mockCubit.state).thenReturn(HomeErrorState("Network error"));
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(HomeErrorState("Network error")));

      await tester.pumpWidget(createTestWidget(mockCubit));
      await tester.pumpAndSettle();

      expect(find.text("Network error"), findsOneWidget);
    });
  });
}
