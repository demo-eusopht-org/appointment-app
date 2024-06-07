import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../resources/assets.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
              text: 'Privacy Policy',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      textWidget(
                        text: 'Privacy Policy',
                        fSize: 18.0,
                        fWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  textWidget(
                    text:
                        "This Privacy Policy governs the manner in which Medical Appointment collects, uses, maintains, and discloses      information collected from users (each, a User) of the Medical Appointment mobile application (App). This Privacy Policy applies to the App and all products and services offered by Medical Appointment.",
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      textWidget(
                        text: 'Terms of Service',
                        fSize: 18.0,
                        fWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  textWidget(
                    text:
                        "Please read these Terms of Service (Terms) carefully before using the Medical Appointment mobile application (the Service) operated by [Appointment managment] (we or us)\n\n.By accessing or using the Service, you agree to be bound by these Terms. If you disagree with any part of the terms, then you do not have permission to access the Service.",
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      textWidget(
                        text: 'Content',
                        fSize: 18.0,
                        fWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  textWidget(
                    text:
                        "You are responsible for the content you post on or through the Service. By posting content, you represent and warrant that you own it or have the right to use it. We reserve the right to terminate the account of anyone found to be infringing on a copyright.",
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      textWidget(
                        text: 'Contact Us',
                        fSize: 18.0,
                        fWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  textWidget(
                    text:
                        "If you have any questions about these Terms, please contact us at [admin@gmail.com]. ",
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.12,
                  )
                ],
              ),
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
        Positioned(
          left: 0,
          bottom: 0,
          child: SafeArea(
            child: Image.asset(
              AppImages.vectorPatient,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
