import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/views/auth/login.dart';
import 'package:appointment_management/src/views/auth/widgets/custom_textfield.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            right: 0,
            child: Image.asset(
              AppImages.vector10,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              AppImages.vector9,
            ),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // "Sign Up" text
                    Text(
                      'Sign Up',
                      style: MyTextStyles.boldtitleblack,
                    ),

                    // Account Icon in Circle
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Appcolors.lightTheme.primaryColor,
                      ),
                      child: Image(
                        image: AssetImage(AppImages.account),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.001), // 2% of the screen height for spacing

                    // Form
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email address',
                      textStyle: MyTextStyles.formtext,
                    ),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Name',
                      textStyle: MyTextStyles.formtext,
                    ),
                    CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        textStyle: MyTextStyles.formtext,
                        obscureText: true,
                        showPasswordIcon: true),
                    CustomTextField(
                        controller: repeatPasswordController,
                        hintText: 'Repeat Password',
                        textStyle: MyTextStyles.formtext,
                        obscureText: true),
                    SizedBox(
                      height: 10,
                    ),
                    // "Sign up" button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.lightTheme.primaryColor,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.3,
                            MediaQuery.of(context).size.height *
                                0.06), // 40% width, 6% height
                      ),
                      onPressed: () {
                        // Implement your signup logic here
                      },
                      child: Text(
                        'Sign up',
                        style: MyTextStyles.boldTextWhite,
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'CONTINUE WITH',
                      style: TextStyle(fontSize: 10.sp),
                    ),

                    SizedBox(
                      height: 5,
                    ), // 2% of the screen height for spacing

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
                            width: MediaQuery.of(context).size.width *
                                0.05, // 8% of the screen width
                            height: MediaQuery.of(context).size.width *
                                0.05, // 8% of the screen width
                          ),
                        ),
                        // Reduce the gap here
                        IconButton(
                          onPressed: () {
                            // Implement your Apple sign up logic here
                          },
                          icon: Image.asset(
                            'assets/images/apple_logo.png',
                            width: MediaQuery.of(context).size.width *
                                0.05, // 8% of the screen width
                            height: MediaQuery.of(context).size.width *
                                0.05, // 8% of the screen width
                          ),
                        ),
                      ],
                    ),

                    // 2% of the screen height for spacing

                    // "Already have an account" text
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Already Have An Account?',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
