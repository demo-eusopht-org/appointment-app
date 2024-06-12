import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Auth/otp_screen.dart';
import 'package:appointment_management/src/views/Auth/widgets/change_password.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isOtpSent = false;
  bool isVerified = false;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  Api? api;

  final int otpLength = 4;
  List<TextEditingController> _controllers = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  ValueNotifier<Map<String, dynamic>?> selectedRole =
      ValueNotifier<Map<String, dynamic>?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Forgot Password',
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.rightvectordesign,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              AppImages.vector10,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              AppImages.vector9,
            ),
          ),
          if (isVerified)
            ChangePassword(
              fromSettingPage: false,
              email: emailController.text,
              roleId: selectedRole.value!['key'].toString(),
            )
          else if (isOtpSent)
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      _buildOTPDigitFields(),
                      const SizedBox(height: 20),
                      Builder(builder: (context) {
                        if (isLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).width * 0.1,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: RoundedElevatedButton(
                            borderRadius: 6,
                            onPressed: () {
                              verifyOtp();
                            },
                            text: 'Submit',
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            )
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.safety,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textWidget(
                        text: 'Forget Password',
                        color: Colors.black,
                        fSize: 18.0,
                        fWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textWidget(
                        text:
                            'Enter your email for the verification proccess,we will send 4 digits code to your email.',
                        fSize: 14,
                        fWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your Email Address',
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.sp),
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
                                    items: Constants.roles
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
                        height: 20,
                      ),
                      Builder(builder: (context) {
                        if (isLoading) {
                          return const Loader();
                        }
                        return Container(
                          height: MediaQuery.sizeOf(context).width * 0.1,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: RoundedElevatedButton(
                            onPressed: () {
                              forgotPassword();
                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) => OtpScreen(),
                              //   ),
                              // );
                            },
                            text: 'Confirm',
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOTPDigitFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(otpLength, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            controller: _controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) {
              if (value.length == 1) {
                // Move focus to the next field, if available
                _moveToNextField(index);
              }
            },
            decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _moveToNextField(int index) {
    if (index < otpLength - 1) {
      FocusScope.of(context).nextFocus();
    } else {
      verifyOtp();
    }
  }

  Future<void> forgotPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      log('keyyyy ${emailController.text}');
      log('keyyyy ${selectedRole.value!['key']!}');
      dynamic res = await api!.forgotPassword(
        {
          "email": emailController.text,
          "role_id": selectedRole.value!['key']!,
        },
      );

      if (res['status'] == 200) {
        CustomDialogue.message(context: context, message: res['message']);
        setState(() {
          isOtpSent = true;
        });
      } else {
        if (res.toString().contains('message')) {
          CustomDialogue.message(context: context, message: res['message']);
        } else {
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
    } catch (e) {
      log('Something went wrong in sending otp api $e');
      CustomDialogue.message(
          // ignore: use_build_context_synchronously
          context: context,
          message: 'Something went wrong in sending otp: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> verifyOtp() async {
    try {
      String otp = _controllers.map((controller) => controller.text).join();

      setState(() {
        isLoading = true;
      });

      dynamic res = await api!.verifyOtpResetPass(
        {
          "email": emailController.text,
          "otp": otp,
        },
      );

      if (res['status'] == 200) {
        CustomDialogue.message(context: context, message: res['message']);
        isVerified = true;
      } else {
        if (res.toString().contains('message')) {
          CustomDialogue.message(context: context, message: res['message']);
        } else {
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Something went wrong in forgot password api $e');
      CustomDialogue.message(
          context: context, message: 'OTP sending failed: $e');
    }
  }

  Future<void> _init() async {
    for (int i = 0; i < otpLength; i++) {
      _controllers.add(TextEditingController());
    }
    api ??= Api(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }
}
