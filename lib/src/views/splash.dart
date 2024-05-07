import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/auth/login.dart';
import 'package:appointment_management/src/views/home/home_screen.dart';
import 'package:appointment_management/src/views/option/option.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 5), () {
      final user = locator<LocalStorageService>().getData(key: 'user');
      print('user ${user}');
      if (user != null && user['token'] != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.logo),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
