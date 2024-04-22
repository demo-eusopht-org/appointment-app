import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/auth/otp_screen.dart';
import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
