import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Auth/login.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  final bool fromSettingPage;
  final String? email;
  final String? roleId;
  const ChangePassword({
    super.key,
    required this.fromSettingPage,
    this.email,
    this.roleId,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Api? api;

  @override
  void initState() {
    api ??= Api(
      dio,
      baseUrl: Constants.baseUrl,
    );
    if (widget.fromSettingPage) {}
    super.initState();
  }

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.fromSettingPage
          ? null
          : customAppBar(
              context: context,
              leadingIcon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: 'Update password',
            ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10.sp,
              ),
              if (widget.fromSettingPage)
                TextField(
                  controller: oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter old Password',
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
              if (widget.fromSettingPage)
                SizedBox(
                  height: 10.sp,
                ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter new Password',
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
              SizedBox(
                height: 10.sp,
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm new Password',
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
              SizedBox(
                height: 10.sp,
              ),
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
                      if (widget.fromSettingPage) {
                        if (passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty ||
                            oldPasswordController.text.isEmpty) {
                          CustomDialogue.message(
                              context: context,
                              message: 'Please fill all fields');
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          CustomDialogue.message(
                              context: context,
                              message:
                                  'Password and Confirm Password does not matched');
                        } else {
                          if (_formKey.currentState!.validate()) {
                            changePassword('', passwordController.text, '',
                                oldPasswordController.text);
                          }
                        }
                      } else {
                        if (passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          CustomDialogue.message(
                              context: context,
                              message: 'Please fill both fields');
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          CustomDialogue.message(
                              context: context,
                              message:
                                  'Password and Confirm Password does not matched');
                        } else {
                          if (_formKey.currentState!.validate()) {
                            changePassword(
                                widget.email!,
                                passwordController.text,
                                widget.roleId!,
                                oldPasswordController.text);
                          }
                        }
                      }
                    },
                    text: widget.fromSettingPage
                        ? 'Update Password'
                        : 'Change Password',
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changePassword(
      String email, String password, String roleId, String? oldPassword) async {
    try {
      setState(() {
        isLoading = true;
      });
      dynamic res;
      if (widget.fromSettingPage) {
        final userData = GetLocalData.getUser();
        res = await api!.updatePassword({
          "email": userData.email,
          "old_password": oldPassword,
          "password": password,
          "role_id": userData.roleId,
        });
      } else {
        res = await api!.resetPassword(
          {
            "email": email,
            "password": password,
            "role_id": roleId,
          },
        );
      }

      if (res['status'] == 200) {
        CustomDialogue.message(context: context, message: res['message']);
        await Future.delayed(const Duration(seconds: 1));
        if (widget.fromSettingPage) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      } else {
        if (res.toString().contains('message')) {
          CustomDialogue.message(context: context, message: res['message']);
        } else {
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
    } catch (e) {
      log('Something went wrong in updating password api $e');
      CustomDialogue.message(
          // ignore: use_build_context_synchronously
          context: context,
          message: 'Something went wrong in updating password: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
