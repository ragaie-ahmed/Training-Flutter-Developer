import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/helper/on_generate_routes.dart';
import 'package:tharadtech/features/App_Localization/Data/app_localization_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AppLocalizationCubit()..changeLanguage(LanguageEvent.initLanguage),
      child: BlocBuilder<AppLocalizationCubit, AppLocalizationState>(
        builder: (context, state) {
          if (state is AppLocalizationChange) {
            return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                locale: Locale(state.appLocal!),
                supportedLocales: const [
                  Locale("ar"),
                  Locale("en"),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,

                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocales, supportedLocales) {
                  for (var local in supportedLocales) {
                    if (deviceLocales != null &&
                        deviceLocales.languageCode == local.languageCode) {
                      return deviceLocales;
                    }
                  }
                  return supportedLocales.first;
                },
                routerConfig: AppRoutes.router,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                  useMaterial3: true,
                ),
              );
            },
          );
          }

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                supportedLocales: const [Locale("ar"), Locale("en")],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocales, supportedLocales) {
                  for (var local in supportedLocales) {
                    if (deviceLocales != null &&
                        deviceLocales.languageCode == local.languageCode) {
                      return deviceLocales;
                    }
                  }
                  return supportedLocales.first;
                },
                routerConfig: AppRoutes.router,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                  useMaterial3: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
