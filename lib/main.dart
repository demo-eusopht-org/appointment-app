import 'package:appointment_management/theme/light/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appointment_management/theme/dark/dark_theme.dart';
import 'package:appointment_management/src/views/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Appointment Management",
            // You can use the library anywhere in the app even in theme
            theme: lightTheme,
            darkTheme: darkTheme,
            home: child,
          );
        },
        child: const SplashScreen());
  }
}
