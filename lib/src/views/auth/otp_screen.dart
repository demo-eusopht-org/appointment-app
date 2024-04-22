import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../resources/assets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
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
                      text: 'Enter 4 Digits Code',
                      color: Colors.black,
                      fSize: 18.0,
                      fWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text: 'Enter the 4 digits code that you received on',
                      fSize: 14,
                      fWeight: FontWeight.w400,
                    ),
                    textWidget(
                      text: 'your email.',
                      fSize: 14,
                      fWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Pinput(
                        defaultPinTheme: PinTheme(
                          margin: EdgeInsets.all(5),
                          textStyle: TextStyle(
                            fontSize: 17,
                          ),
                          height: 60,
                          width: 46,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // listenForMultipleSmsOnAndroid: true,
                        // androidSmsAutofillMethod:
                        //     AndroidSmsAutofillMethod.smsUserConsentApi,
                        length: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        controller: pinController,
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
