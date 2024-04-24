import 'package:appointment_management/src/views/auth/widgets/clinic_item.dart';
import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';
import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/text_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Settings',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: AppColors.buttonColor,
                  height: MediaQuery.sizeOf(context).height * 0.18,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset('assets/images/Vector 1.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset('assets/images/Vector 2.png'),
                      ),
                      Positioned(
                        top: 0,
                        left: 10,
                        bottom: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage(AppImages.men3),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 8,
                                        child: Image.asset(
                                          height: 12,
                                          width: 12,
                                          color: Colors.black,
                                          AppImages.camera,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textWidget2(
                                      text: "Ali",
                                      fSize: 17.0,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    textWidget2(
                                      text: "Ali@gmail.com",
                                      fSize: 8.0,
                                      fWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.47,
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    textWidget2(
                                      text: "Edit",
                                      fSize: 9.0,
                                      fWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: textWidget2(
                                  text: "Remove",
                                  fSize: 9.0,
                                  fWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                textWidget2(
                  text: 'CLINIC PROFILE',
                  fSize: 15.0,
                  fWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 10,
                ),
                ClinicItem(
                  name: 'Opti Clinic',
                  type: "Eye Clinic",
                  imagePath: AppImages.hospital,
                ),
                SizedBox(
                  height: 10,
                ),
                ClinicItem(
                  name: '321 Main Street, Karachi,54321',
                  type: "Pakistan",
                  imagePath: AppImages.location,
                ),
                SizedBox(
                  height: 10,
                ),
                ClinicItem(
                  name: '+92 3217285635',
                  imagePath: AppImages.phone,
                ),
                SizedBox(
                  height: 10,
                ),
                ClinicItem(
                  name: 'Ali@gmail.com',
                  imagePath: AppImages.email,
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _launchUrl('https://www.example.com/');
                  },
                  child: ClinicItem(
                    name: 'https://www.example.com/',
                    imagePath: AppImages.earth,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          textWidget2(
                            text: "Notifactions",
                            fSize: 18.0,
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Switch.adaptive(
                            activeTrackColor: AppColors.buttonColor,
                            value: switchValue,
                            onChanged: (newValue) {
                              setState(() {
                                switchValue = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textWidget2(
                        text: "Privacy Policy",
                        fSize: 18.0,
                        fWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: RoundedElevatedButton(
                    onPressed: () {},
                    text: "Sign Out",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String? url) async {
    print('LinK:$url');
    if (url != null) {
      final uri = url.contains('https') ? Uri.parse(url) : Uri.https(url);
      print('check ${uri.toString()}');
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $url');
      }
    }
  }
}
