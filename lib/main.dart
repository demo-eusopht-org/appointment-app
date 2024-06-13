import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/views/Auth/bloc/auth_bloc.dart';
import 'package:appointment_management/src/views/Auth/loader_bloc.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:appointment_management/src/views/splash.dart';
import 'package:appointment_management/theme/dark/dark_theme.dart';
import 'package:appointment_management/theme/light/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timetable/timetable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeLocator();
  await locator<LocalStorageService>().initializeBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
            localizationsDelegates: const [
              TimetableLocalizationsDelegate(),
            ],
            debugShowCheckedModeBanner: false,
            title: "Appointment Management",
            theme: lightTheme,
            darkTheme: darkTheme,
            home: child,
            builder: (context, child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LoaderBloc(),
                    lazy: true,
                  ),
                  BlocProvider(
                    create: (context) => AuthBloc(),
                    lazy: true,
                  ),
                  BlocProvider(
                    create: (context) => OnBoardingBloc(),
                    lazy: true,
                  ),
                ],
                child: child!,
              );
            });
      },
      child: const SplashScreen(),
    );
  }
}
