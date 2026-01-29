import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharadtech/core/api/service_locator.dart';
import 'package:tharadtech/core/helper/shared_pref_service.dart';
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
  static const String logIn = "/LoginCubit";
  static const String home = "/HomeView";
  static const String profile = "/ProfileScreen";
  static const String initial = "/";

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: initial,

    redirect: (context, state) async {
      final currentPath = state.matchedLocation;

      // جلب الـ token
      final token = await SharedPrefService.getSecuredString(
        SharedPrefService.storedToken,
      );

      final hasToken = token.isNotEmpty;

      // الصفحات اللي ممكن الوصول ليها بدون token
      final isAuthPage = currentPath == logIn ||
          currentPath == register ||
          currentPath == otpView ||
          currentPath == initial;



      // لو مافيش token
      if (!hasToken) {
        // السماح بصفحات Auth
        if (isAuthPage) {
          // لو في الصفحة الأولية، روح login
          if (currentPath == initial) {
            return logIn;
          }
          return null;
        }
        // غير كده ارجع login
        return logIn;
      }

      // لو في token
      // لو في صفحة login أو initial، روح home
      if (currentPath == logIn || currentPath == initial) {
        return home;
      }

      // كل حاجة تانية تمام
      return null;
    },

    routes: [
      GoRoute(
        path: logIn,
        name: 'login',
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getit.get<LogInUseCase>()),
          child: LoginView(),
        ),
      ),

      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => RegisterView(),
      ),

      GoRoute(
        path: otpView,
        name: 'otp',
        builder: (context, state) => BlocProvider(
          create: (context) => OtpCubit(getit.get<OtpUseCase>()),
          child: OtpView(email: state.extra as String),
        ),
      ),

      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeScreenCubit()),
          ],
          child: HomeView(),
        ),
      ),

      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileCubit(
            getit.get<GetProfileUseCase>(),
            getit.get<UpdateProfileUseCase>(),
          )..getProfile(),
          child: ProfileScreen(),
        ),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('خطأ'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 24),
            const Text(
              '404 - الصفحة غير موجودة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'المسار: ${state.uri}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontFamily: 'Tajawal',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go(logIn),
              icon: const Icon(Icons.home),
              label: const Text(
                'العودة للصفحة الرئيسية',
                style: TextStyle(fontFamily: 'Tajawal'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}