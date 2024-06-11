import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/custom_textfield.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => AssigneBranchState();
}

class AssigneBranchState extends State<VerifyEmail> {
  bool isLoading = false;
  bool isOtpSent = false;
  bool isVerified = false;

  Api? api;

  User? userData;

  final _formKey = GlobalKey<FormState>();

  final int otpLength = 4;
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: textWidget(
              text: 'Verify Email Address',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (isVerified || userData!.verified == 1)
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: textWidget(
                      text: 'Your email is verified',
                      fSize: 15.sp,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isOtpSent)
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildOTPDigitFields(),
                                  const SizedBox(height: 20),
                                  Builder(builder: (context) {
                                    if (isLoading) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    return SizedBox(
                                      height: 40,
                                      child: RoundedElevatedButton(
                                        borderRadius: 6,
                                        onPressed: () {
                                          _validateOTP();
                                        },
                                        text: 'Submit',
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            )
                          else
                            Builder(builder: (context) {
                              if (isLoading) {
                                return const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return SizedBox(
                                height: 40,
                                child: RoundedElevatedButton(
                                  borderRadius: 6,
                                  onPressed: () {
                                    sendOtp();
                                  },
                                  text: 'Send otp to your email',
                                ),
                              );
                            }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: SafeArea(
            child: Image.asset(
              "assets/images/add_consultant_vector10.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
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
      // Last digit, so we submit OTP
      _validateOTP();
    }
  }

  Future<void> sendOtp() async {
    try {
      setState(() {
        isLoading = true;
      });

      dynamic res = await api!.sendOtp(
        {"email": userData!.email},
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

  Future<void> _validateOTP() async {
    try {
      String otp = _controllers.map((controller) => controller.text).join();
      log('otp is ${otp}');
      setState(() {
        isLoading = true;
      });

      dynamic res = await api!.verifyOtp(
        {
          "email": userData!.email,
          "user_OTP": otp,
        },
      );

      if (res['status'] == 200) {
        CustomDialogue.message(context: context, message: res['message']);
        isVerified = true;

        updatingUser();
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
      log('Something went wrong in verify email api $e');
      CustomDialogue.message(
          context: context, message: 'OTP verification failed: $e');
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

    userData = GetLocalData.getUser();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> updatingUser() async {
    final userUpdate = User(
        username: userData!.username,
        email: userData!.email,
        createdAt: userData!.createdAt,
        updatedAt: userData!.updatedAt,
        id: userData!.id,
        verified: 1,
        roleId: userData!.roleId);

    final tempUser = locator<LocalStorageService>().getData(key: 'user');

    String token = tempUser['token'];

    AuthResponse user = AuthResponse(token: token, user: userUpdate);

    await locator<LocalStorageService>().delete('user');
    await locator<LocalStorageService>().saveData(
      key: 'user',
      value: user.toJson(),
    );
  }
}
