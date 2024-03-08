import 'package:appointment_management/src/views/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:appointment_management/src/views/auth/widgets/custom_textfield.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/theme/light/light_theme.dart' as Appcolors;
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: SizedBox.expand(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.rightvectordesign),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                  // Title
                  Text(
                    'Sign in',
                    style: MyTextStyles.boldtitleblack,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0001),

                  // Account Icon in Circle
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Appcolors.lightTheme.primaryColor,
                    ),
                    child: Image(image: AssetImage(AppImages.account),

                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,),




                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Form Fields
                  CustomTextField(controller: emailController, hintText: 'Email', textStyle: MyTextStyles.formtext,),
                  CustomTextField(controller: passwordController, hintText: 'Password', textStyle: MyTextStyles.formtext, obscureText: true, showPasswordIcon: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Implement your forgot password logic here
                        },
                        child: Text(
                          'Forgot Password?',

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Appcolors.lightTheme.primaryColor),
                    onPressed: () {
                      Get.to(OnboardingPage());
                    },
                    child: Text('Log in', style: MyTextStyles.boldTextWhite,),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Increase the gap here
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Increase the gap here
                  Text(
                    'CONTINUE WITH', style: TextStyle(fontSize: 10.sp),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04), // Increase the gap here

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Implement your Google sign up logic here
                        },
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          width: MediaQuery.of(context).size.width * 0.05, // 8% of the screen width
                          height: MediaQuery.of(context).size.width * 0.05, // 8% of the screen width
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.001), // Reduce the gap here
                      IconButton(
                        onPressed: () {
                          // Implement your Apple sign up logic here
                        },
                        icon: Image.asset(
                          'assets/images/apple_logo.png',
                          width: MediaQuery.of(context).size.width * 0.05, // 8% of the screen width
                          height: MediaQuery.of(context).size.width * 0.05, // 8% of the screen width
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // 2% of the screen height for spacing
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // 2% of the screen height for spacing

                  // "Create an Account" text
                  GestureDetector(
                    onTap: () {
                      Get.to(SignupPage());

                    },
                    child: Text('Create an Account',),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
