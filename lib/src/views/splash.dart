import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/option/option.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextScreen() async {
    Future.delayed(const Duration(seconds: 5), () async {
      Get.to(() => OptionScreen());
    });
  }

  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.theme.colorScheme.background,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.logo,
                ),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
