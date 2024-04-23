import 'package:appointment_management/src/views/Consultant/add_consultant.dart';
import 'package:appointment_management/src/views/appointments/appointments.dart';
import 'package:appointment_management/src/views/auth/bloc/loader_bloc.dart';
import 'package:appointment_management/theme/dark/dark_theme.dart';
import 'package:appointment_management/theme/light/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/views/auth/bloc/login_bloc.dart';

void main() {
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
                  ),
                  BlocProvider(
                    create: (context) => LoginBloc(),
                  ),
                ],
                child: child!,
              );
            });
      },
      child: const Appointments(),
    );
  }
}
