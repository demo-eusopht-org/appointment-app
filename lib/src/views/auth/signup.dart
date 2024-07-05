import 'dart:developer';

import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/email_validator.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_events.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_states.dart';
import 'package:appointment_management/src/views/Auth/bloc/auth_bloc.dart';
import 'package:appointment_management/src/views/Auth/login.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // resizeToAvoidBottomInset: false,
      body: BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          log('state is ${state}');
          if (state is AuthFailureState) {
            CustomDialogue.message(context: context, message: state.message);
          } else if (state is AuthSuccessState) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const OnboardingPage(
                  isUpdate: false,
                ),
              ),
            );
          }
        },
        child: Form(
          key: formKey,
          child: Stack(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),

                        textWidget(
                          text: 'Sign Up',
                          fSize: 25.sp,
                          fWeight: FontWeight.bold,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Image(
                            image: AssetImage(AppImages.account),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                        ),
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.001), // 2% of the screen height for spacing

                        // Form
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          validator: (String? value) {
                            if (value == null || value == '') {
                              return 'Please fill name field';
                            }
                            return null;
                          },
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
                          onChanged: (value) {
                            emailController.value = TextEditingValue(
                                text: value.trim(),
                                selection: emailController.selection);
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (String? value) {
                            print('value ${value}');
                            if (value == null || value == '') {
                              return 'Please fill password field';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),

                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          validator: (String? value) {
                            if (value == null || value == '') {
                              return 'Please fill confirm password field';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // "Sign up" button
                        BlocBuilder<AuthBloc, AuthStates>(
                            bloc: BlocProvider.of<AuthBloc>(context),
                            builder: (context, state) {
                              if (state is AuthLoadingState) {
                                return const CircularProgressIndicator();
                              }

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.3,
                                    MediaQuery.of(context).size.height * 0.06,
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (passwordController.text.trim() ==
                                        confirmPasswordController.text.trim()) {
                                      signUp();
                                    } else {
                                      CustomDialogue.message(
                                          context: context,
                                          message:
                                              'Password and Confirm Password does not matched');
                                    }
                                  }
                                },
                                child: textWidget(
                                  text: 'Sign up',
                                  color: AppColors.white,
                                  fWeight: FontWeight.bold,
                                ),
                              );
                            }),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        // textWidget(
                        //   text: 'CONTINUE WITH',
                        // ),

                        const SizedBox(
                          height: 5,
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {
                        //         // Implement your Google sign up logic here
                        //       },
                        //       icon: Image.asset(
                        //         'assets/images/google_logo.png',
                        //         width: MediaQuery.of(context).size.width *
                        //             0.05, // 8% of the screen width
                        //         height: MediaQuery.of(context).size.width *
                        //             0.05, // 8% of the screen width
                        //       ),
                        //     ),
                        //     // Reduce the gap here
                        //     IconButton(
                        //       onPressed: () {
                        //         // Implement your Apple sign up logic here
                        //       },
                        //       icon: Image.asset(
                        //         'assets/images/apple_logo.png',
                        //         width: MediaQuery.of(context).size.width *
                        //             0.05, // 8% of the screen width
                        //         height: MediaQuery.of(context).size.width *
                        //             0.05, // 8% of the screen width
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: textWidget(
                            text: 'Already Have An Account? Login',
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpEvent(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }
}
