import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/views/auth/bloc/loader_bloc.dart';
import 'package:appointment_management/src/views/auth/bloc/login_bloc.dart';
import 'package:appointment_management/src/views/auth/signup.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_password.dart';

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
                    child: Image(
                      image: AssetImage(AppImages.account),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Form Fields
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.lightTheme.primaryColor,
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.3,
                          MediaQuery.of(context).size.height *
                              0.06), // 40% width, 6% height
                    ),
                    onPressed: () {
                      _login(context);
                    },
                    child: Text(
                      'Sign in',
                      style: MyTextStyles.boldTextWhite,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Loader
                  BlocBuilder<LoaderBloc, bool>(
                    builder: (context, isLoading) {
                      if (isLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ), // Increase the gap here
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ), // Increase the gap here
                  Text(
                    'CONTINUE WITH',
                    style: TextStyle(fontSize: 10.sp),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ), // Increase the gap here

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
                      SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.001, // Reduce the gap here
                      ),
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

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ), // 2% of the screen height for spacing
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ), // 2% of the screen height for spacing

                  // "Create an Account" text
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Create an Account',
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

  void _login(BuildContext context) {
    context.read<LoaderBloc>().add(ShowLoaderEvent());

    Future.delayed(Duration(seconds: 5), () {
      context.read<LoaderBloc>().add(HideLoaderEvent());
      context.read<LoginBloc>().add(LoginSuccess());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => OnboardingPage()));
    });
  }
}
