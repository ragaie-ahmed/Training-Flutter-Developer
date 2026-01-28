import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharadtech/core/api/service_locator.dart';
import 'package:tharadtech/features/Auth/domain/usecase/log_in_use_case.dart';
import 'package:tharadtech/features/Auth/domain/usecase/opt_use_case.dart';
import 'package:tharadtech/features/Auth/presentation/View/LogIn/Screen/login_view.dart';
import 'package:tharadtech/features/Auth/presentation/View/Otp/Screen/otp_view.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Screen/register_view.dart';
import 'package:tharadtech/features/Auth/presentation/manage/login/login_cubit.dart';
import 'package:tharadtech/features/Auth/presentation/manage/otp/otp_cubit.dart';
import 'package:tharadtech/features/Home/presentation/manage/home_screen/home_screen_cubit.dart';
import 'package:tharadtech/features/Home/presentation/view/Screen/home_view.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Screen/profile_screen.dart';
import 'package:tharadtech/features/Profile/Presentation/manage/profile_cubit.dart';
import 'package:tharadtech/features/Profile/domain/usecase/get_profile_use_case.dart';
import 'package:tharadtech/features/Profile/domain/usecase/update_profile_use_case.dart';

class AppRoutes {
  static const String register = "/RegisterView";
  static const String otpView = "/OtpView";
  static const String logIn = "/LoginView";
  static const String home = "/HomeView";
  static const String profile = "/ProfileScreen";
  static final GoRouter router = GoRouter(
    initialLocation: home,

    routes: [
      GoRoute(path: register, builder: (context, state) => RegisterView()),
      GoRoute(
        path: profile,
        builder: (context, state) =>  ProfileScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => MultiBlocProvider(
  providers: [
    BlocProvider(
          create: (context) => HomeScreenCubit(),
),
  ],
  child: HomeView(),
),
      ),
      GoRoute(
        path: logIn,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getit.get<LogInUseCase>()),
          child: LoginView(),
        ),
      ),
      GoRoute(
        path: otpView,
        builder: (context, state) => BlocProvider(
          create: (context) => OtpCubit(getit.get<OtpUseCase>()),
          child: OtpView(email: state.extra as String),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(child: Text('404 - Page Not Found')),
    ),
  );
}
