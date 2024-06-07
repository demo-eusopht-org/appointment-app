import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/views/Auth/login.dart';
import 'package:appointment_management/src/views/Auth/signup.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as AppColors;
import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.3), // Adjust the value to move the logo up
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Adjust the width based on your image size
              height: MediaQuery.of(context).size.height *
                  0.2, // Adjust the height based on your image size
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.logo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightTheme.primaryColor,
                  ),
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: MyTextStyles.boldTextWhite,
                  ),
                ),
                SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightTheme.primaryColor,
                  ),
                  onPressed: () {
                    // Navigate to signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Signup',
                    style: MyTextStyles.boldTextWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
