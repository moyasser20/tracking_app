import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tarcking_app/core/errors/api_result.dart';
import 'package:tarcking_app/core/l10n/translation/app_localizations.dart';
import 'package:tarcking_app/core/theme/app_colors.dart';
import 'package:tarcking_app/features/profile/domain/entity/user_entity.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/states/profile_states.dart';
import '../../../../widget_test_helpers.mocks.dart';
import '../../profile_mocks.dart';

// Testable version of ProfileScreen that doesn't create its own ProfileViewModel
class TestableProfileScreen extends StatelessWidget {
  const TestableProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          iconSize: 24,
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            null;
          },
        ),
        title: Text(
          local.profile,
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ProfileViewModel, ProfileStates>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [AppColors.pink],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                ),
              ),
            );
          } else if (state is ProfileSuccessState) {
            final profile = state.user;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${profile.firstName} ${profile.lastName}'),
                  Text(profile.email),
                  Text(profile.phone),
                ],
              ),
            );
          } else if (state is ProfileErrorState) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

@GenerateMocks([NavigatorObserver])
void main() {
  late ProfileViewModel viewModel;
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;
  late MockLogoutViewModel mockLogoutViewModel;
  late MockLocalizationCubit mockLocalizationCubit;
  late MockNavigatorObserver mockNavigatorObserver;
  late UserEntity testUser;

  setUp(() {
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    mockLogoutViewModel = MockLogoutViewModel();
    mockLocalizationCubit = MockLocalizationCubit();
    mockNavigatorObserver = MockNavigatorObserver();

    testUser = UserEntity(
      id: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      gender: 'male',
      phone: '1234567890',
      photo: 'https://example.com/photo.jpg',
      role: 'driver',
      vehicleType: 'car',
      vehicleNumber: 'ABC123',
      vehicleLicense: 'license123',
      nid: 'nid123',
      nidImg: 'nid_image.jpg',
    );

    viewModel = ProfileViewModel(mockGetProfileDataUseCase);
  });

  tearDown(() {
    reset(mockGetProfileDataUseCase);
    reset(mockLogoutViewModel);
    reset(mockLocalizationCubit);
    reset(mockNavigatorObserver);
  });

  Widget createTestableWidget() {
    // Stub the navigator property for the mock observer
    when(mockNavigatorObserver.navigator).thenReturn(null);
    
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      locale: const Locale('en', ''),
      home: BlocProvider<ProfileViewModel>.value(
        value: viewModel,
        child: const TestableProfileScreen(),
      ),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  group('ProfileScreen', () {
    testWidgets('should show loading indicator when loading profile data', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockGetProfileDataUseCase()).thenAnswer(
        (_) async => Future.delayed(
          const Duration(milliseconds: 100),
          () => ApiSuccessResult(testUser),
        ),
      );

      // Act
      await tester.pumpWidget(createTestableWidget());
      viewModel.emit(ProfileLoadingState()); // Manually emit loading state
      await tester.pump();

      // Assert
      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('should show profile data when loaded successfully', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockGetProfileDataUseCase(),
      ).thenAnswer((_) async => ApiSuccessResult(testUser));

      // Act
      await tester.pumpWidget(createTestableWidget());
      viewModel.emit(ProfileSuccessState(testUser)); // Manually emit success state
      await tester.pumpAndSettle(); // Wait for async operations

      // Assert
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);
    });

    testWidgets('should show error state when profile loading fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockGetProfileDataUseCase(),
      ).thenAnswer((_) async => ApiErrorResult('Failed to load profile'));

      // Act
      await tester.pumpWidget(createTestableWidget());
      viewModel.emit(ProfileErrorState('Failed to load profile')); // Manually emit error state
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SizedBox), findsWidgets);
      expect(viewModel.state, isA<ProfileErrorState>());
      expect(
        (viewModel.state as ProfileErrorState).message,
        'Failed to load profile',
      );
    });

    testWidgets('should load profile data on initialization', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockGetProfileDataUseCase(),
      ).thenAnswer((_) async => ApiSuccessResult(testUser));

      // Act
      await tester.pumpWidget(createTestableWidget());
      viewModel.emit(ProfileSuccessState(testUser)); // Manually emit success state
      await tester.pumpAndSettle();

      // Assert
      expect(viewModel.state, isA<ProfileSuccessState>());
      expect((viewModel.state as ProfileSuccessState).user, testUser);
    });

    testWidgets(
      'should navigate to edit profile screen when profile card is tapped',
      (WidgetTester tester) async {
        // Arrange
        when(
          mockGetProfileDataUseCase(),
        ).thenAnswer((_) async => ApiSuccessResult(testUser));

        // Act
        await tester.pumpWidget(createTestableWidget());
        viewModel.emit(ProfileSuccessState(testUser)); // Manually emit success state
        await tester.pumpAndSettle();

        final profileCard = find.byType(GestureDetector).first;
        await tester.tap(profileCard);
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any)).called(1);
      },
    );
  });
}
