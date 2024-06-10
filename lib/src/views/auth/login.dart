import 'dart:developer';

import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/utils/email_validator.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_events.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_states.dart';
import 'package:appointment_management/src/views/Auth/bloc/auth_bloc.dart';
import 'package:appointment_management/src/views/Auth/loader_bloc.dart';

import 'package:appointment_management/src/views/Auth/signup.dart';

import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/home/home_screen.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';
import 'package:appointment_management/src/views/splash.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/assets.dart';
import '../../resources/textstyle.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> roles = [
    {
      'key': 1,
      'value': 'Admin',
    },
    {
      'key': 2,
      'value': 'Consultant',
    },
  ];
  ValueNotifier<Map<String, dynamic>?> selectedRole =
      ValueNotifier<Map<String, dynamic>?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          log('state is ${state}');
          if (state is AuthFailureState) {
            CustomDialogue.message(context: context, message: state.message);
          } else if (state is AuthSuccessState) {
            // Navigator.pushReplacement(
            //   context,
            //   CupertinoPageRoute(
            //     builder: (context) => const HomeScreen(),
            //   ),
            // );
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const SplashScreen(
                  fromLogin: true,
                ),
              ),
            );
          }
        },
        child: Form(
          key: formKey,
          child: Stack(children: [
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
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),

                      // Title
                      Text(
                        'Sign in',
                        style: MyTextStyles.boldtitleblack,
                      ),

                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        child: Image(
                          image: AssetImage(AppImages.account),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (String? value) {
                          if (value == null || value == '') {
                            return 'Please fill email address';
                          }
                          return value.isValidEmail()
                              ? null
                              : 'Please fill correct email format';
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (String? value) {
                          if (value == null && value == '') {
                            return 'Please fill password field';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: selectedRole,
                              builder: (context, value, child) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 0.1,
                                      )),
                                  child: DropdownButton<Map<String, dynamic>?>(
                                    value: selectedRole.value,
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    dropdownColor: AppColors.white,
                                    hint: textWidget(text: 'Select role'),
                                    items: roles
                                        .map(
                                          (Map<String, dynamic> role) =>
                                              DropdownMenuItem<
                                                      Map<String, dynamic>?>(
                                                  value: role,
                                                  child: textWidget(
                                                    text: role['value'],
                                                  )),
                                        )
                                        .toList(),
                                    onChanged: (Map<String, dynamic>? value) {
                                      if (value != null) {
                                        selectedRole.value = value;
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
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
                      SizedBox(
                        height: 10,
                      ),
                      // Login Button
                      BlocBuilder<AuthBloc, AuthStates>(
                        bloc: BlocProvider.of<AuthBloc>(context),
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return CircularProgressIndicator();
                          }

                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,

                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.3,
                                  MediaQuery.of(context).size.height *
                                      0.06), // 40% width, 6% height
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (selectedRole.value != null) {
                                  login();
                                } else {
                                  CustomDialogue.message(
                                      context: context,
                                      message: 'Please select role');
                                }
                              }
                            },
                            // child: Text(
                            //   'Sign in',
                            //   style: MyTextStyles.boldTextWhite,
                            // ),
                            child: textWidget(
                              text: 'Sign in',
                              color: AppColors.white,
                              fWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),

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

                      // Increase the gap here
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ), // Increase the gap here
                      Text(
                        'CONTINUE WITH',
                        style: TextStyle(fontSize: 10.sp),
                      ),

                      SizedBox(
                        height: 10,
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                        child: Text(
                          'Create an Account',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> login() async {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        roleId: selectedRole.value!['key']!,
      ),
    );
  }
}
