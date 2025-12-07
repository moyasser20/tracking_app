import 'package:flutter/material.dart';
import 'package:tarcking_app/core/routes/route_names.dart';
import 'package:tarcking_app/features/profile/change_password/presentation/viewmodel/change_password_viewmodel.dart';
import '../../features/auth/presentation/apply/view/apply_screen.dart';
import '../../features/auth/presentation/apply/view/application_approved_screen.dart';
import '../../features/homescreen/domain/entities/order_entity.dart';
import '../../features/homescreen/presentation/view/home_screen.dart';
import '../../features/homescreen/presentation/viewmodel/home_cubit.dart';
import '../../features/onboarding/presentation/view/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/config/di.dart';
import 'package:tarcking_app/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:tarcking_app/features/auth/presentation/login/view/login_screen.dart';
import '../../features/dashboard/presentation/views/dashboard_screen.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/viewmodel/forget_password_viewmodel.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/views/screens/forget_password_screen.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/views/screens/email_verificationScreen.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/views/screens/reset_password_screen.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/viewmodel/verify_code_viewmodel.dart';
import 'package:tarcking_app/features/auth/presentation/forget_password/presentation/viewmodel/reset_password_viewmodel.dart';
import '../../features/order_details/data/models/order_details_model.dart';
import '../../features/order_details/presentation/cubit/order_details_cubit.dart';
import '../../features/order_details/presentation/views/order_details_screen.dart';
import '../../features/order_location/presentation/view/order_map_screen.dart';
import '../../features/profile/change_password/presentation/views/screens/change_password_screen.dart';
import '../../features/profile/domain/entity/user_entity.dart';
import '../../features/profile/presentation/view/edit_profile_screen.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.applicationApproved:
        return MaterialPageRoute(
          builder: (context) => const ApplicationApprovedScreen(),
          settings: settings,
        );

      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
        );

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardScreen());

      case AppRoutes.apply:
        return MaterialPageRoute(builder: (_) => const ApplyScreen());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ForgetPasswordCubit>(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: const ForgetPasswordScreen(),
              ),
        );
      case AppRoutes.changePasswordScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ChangePasswordViewModel>(
                create: (context) => getIt<ChangePasswordViewModel>(),
                child: const ChangePasswordScreen(),
              ),
        );

      case AppRoutes.editProfile:
        final user = settings.arguments as UserEntity;
        return MaterialPageRoute(builder: (_) => EditProfileScreen(user: user));

      case AppRoutes.emailVerification:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<VerifyCodeCubit>(
                create: (context) => getIt<VerifyCodeCubit>(),
                child: EmailVerificationScreen(email: email),
              ),
        );

      case AppRoutes.resetPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ResetPasswordCubit>(
                create: (context) => getIt<ResetPasswordCubit>(),
                child: ResetPasswordScreen(email: email),
              ),
        );

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<HomeCubit>()..getOrders(),
                child: const HomeScreen(),
              ),
        );

      case AppRoutes.orderDetails:
        final orderEntity = settings.arguments as OrderEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OrderDetailsCubit>(),
            child: OrderDetailsScreen(
              orderEntity: orderEntity,
              onOrderUpdated: () {
                getIt<HomeCubit>().getOrders();
              },
            ),
          ),
        );

      case AppRoutes.orderMapScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final order = args['order'] as OrderDetails;
        final isFromPickup = args['isFromPickup'] as bool;
        return MaterialPageRoute(
          builder: (context) => OrderMapScreen(
            order: order,
            isFromPickupRoute: isFromPickup,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }
  }
}
