import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/l10n/translation/app_localizations.dart';
import 'package:tarcking_app/core/routes/on_generate_route.dart';
import 'package:tarcking_app/core/routes/route_names.dart';
import 'package:tarcking_app/core/contants/secure_storage.dart';
import 'package:tarcking_app/features/profile/presentation/viewmodel/edit_profile_viewmodel.dart';
import 'package:tarcking_app/firebase_options.dart';
import 'core/config/di.dart';
import 'features/localization/data/localization_preference.dart';
import 'features/localization/localization_controller/localization_cubit.dart';
import 'features/localization/localization_controller/localization_state.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/presentation/viewmodel/profile_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();
  await SecureStorage.initialize();
  String languageValue = await LocalizationPreference.getLanguage();
  final String resolvedInitialRoute = AppRoutes.initial;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileViewModel>(
          create: (_) => getIt<ProfileViewModel>()..getProfile(),
        ),
        BlocProvider<EditProfileViewModel>(
          create: (_) => getIt<EditProfileViewModel>(),
        ),
        BlocProvider<LocalizationCubit>(
          create: (BuildContext context) => LocalizationCubit(language: languageValue),
        ),
      ],
      child: MyApp(initialRoute: resolvedInitialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        final cubit = context.read<LocalizationCubit>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tracking App',
          theme: AppTheme.lightTheme,
          initialRoute: initialRoute,
          onGenerateRoute: Routes.onGenerateRoute,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale:
              cubit.language == "en" ? const Locale("en") : const Locale("ar"),
        );
      },
    );
  }
}
