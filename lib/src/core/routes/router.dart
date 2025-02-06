library route_pages;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/error/error.dart';
import 'package:task_app/src/core/helpers/extensions.dart';
import 'package:task_app/src/core/helpers/shared_pref_helper.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/user_data.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:task_app/src/features/auth/presentation/pages/signup_page.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:task_app/src/features/home/presentation/pages/dashboard_pages/dashboard_page.dart';
import 'package:task_app/src/features/home/presentation/pages/success_page.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesNames.initial:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const LoginPage(),
          ),
        );
      case RoutesNames.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const LoginPage(),
          ),
        );
      case RoutesNames.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const SignupPage(),
          ),
        );
      case RoutesNames.dashboard:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                  value: getIt<DashboardCubit>()..startConnectivityListener()),
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: getIt<CreateTaskCubit>()),
              BlocProvider.value(
                  value: getIt<ProfileCubit>()..setUserOldData()),
            ],
            child: const DashboardPage(),
          ),
        );
      case RoutesNames.success:
        return MaterialPageRoute(
          builder: (_) => const SuccessPage(),
        );

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }

  /// this function open home page directly if user logged in before
  /// and get user data from data base to be used directly in app without
  /// accessing it again
  static Future<String> getInitialRoute() async {
    try {
      String? token =
          await SharedPrefHelper.getSecuredString(key: DataBaseKeys.token);
      if (token.isNullOrEmpty()) {
        return RoutesNames.login;
      } else {
        UserData.email =
            await SharedPrefHelper.getString(key: DataBaseKeys.userEmail);
        UserData.name =
            await SharedPrefHelper.getString(key: DataBaseKeys.userName);
        UserData.token = token;
        return RoutesNames.dashboard;
      }
    } catch (e) {
      // Handle potential errors here (e.g., logging)
      return RoutesNames.login; // Default to login if there's an error
    }
  }
}
