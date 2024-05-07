import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/auth/otp_screen.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                      text: 'Reset Password',
                      color: Colors.black,
                      fSize: 18.0,
                      fWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text:
                          'Set the new password for your account so you can login and access all the features.',
                      fSize: 14,
                      fWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: textWidget2(
                        text: "New Password",
                        fSize: 14.0,
                        fWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility),
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
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: textWidget2(
                        text: "Confirm Password",
                        fSize: 14.0,
                        fWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility),
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
                      height: 20,
                    ),
                    Container(
                      height: 37,
                      width: 220,
                      child: RoundedElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => OtpScreen(),
                            ),
                          );
                        },
                        text: 'Confirm',
                      ),
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
