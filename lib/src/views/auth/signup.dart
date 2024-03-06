  import 'package:appointment_management/src/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import 'package:appointment_management/src/views/auth/widgets/custom_textfield.dart';
  import 'package:appointment_management/src/resources/textstyle.dart';
  import 'package:appointment_management/theme/light/light_theme.dart' as Appcolors;
  import 'package:appointment_management/src/resources/assets.dart';

  class SignupPage extends StatefulWidget {
    @override
    _SignupPageState createState() => _SignupPageState();
  }

  class _SignupPageState extends State<SignupPage> {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Get.theme.colorScheme.background,
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
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05), // 5% of the screen width as padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1), // 10% of the screen height

                    // "Sign Up" text
                    Text(
                      'Sign Up',
                      style: MyTextStyles.boldtitleblack,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.0001), // 2% of the screen height for spacing

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
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.001), // 2% of the screen height for spacing

                    // Form
                    CustomTextField(controller: emailController, hintText: 'Email address', textStyle: MyTextStyles.formtext,),
                    CustomTextField(controller: nameController, hintText: 'Name', textStyle: MyTextStyles.formtext,),
                    CustomTextField(controller: passwordController, hintText: 'Password', textStyle: MyTextStyles.formtext, obscureText: true, showPasswordIcon: true),
                    CustomTextField(controller: repeatPasswordController, hintText: 'Repeat Password', textStyle: MyTextStyles.formtext, obscureText: true),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06), // 6% of the screen height for spacing

                    // "Sign up" button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.lightTheme.primaryColor,
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.06), // 40% width, 6% height
                      ),
                      onPressed: () {
                        // Implement your signup logic here
                      },
                      child: Text('Sign up', style: MyTextStyles.boldTextWhite,),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01), // 1% of the screen height for spacing

                    // "Continue with" text
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Increase the gap here
                    Text(
                      'CONTINUE WITH', style: TextStyle(fontSize: 10.sp),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01), // 2% of the screen height for spacing

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

                    // "Already have an account" text
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginPage());
                      },
                      child: Text(
                        'Already Have An Account?',

                      ),
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

