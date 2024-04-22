import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../Consultant/consultant_details.dart';
import '../auth/widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> popularLocations = [
    {'name': 'New York', 'image': AppImages.doctor1},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Hi, Ali!',
        leadingIcon: Image.asset(
          AppImages.menuIcon,
        ),
        action: [
          Image.asset(
            AppImages.notification,
            width: 50,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            AppImages.right,
                            width: 164,
                            height: 53,
                            fit: BoxFit.cover,
                          ),
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textWidget(
                                  textAlign: TextAlign.center,
                                  text: 'Today Appointments',
                                  color: Colors.white,
                                  fSize: 10.0,
                                  fWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                textWidget2(
                                  textAlign: TextAlign.center,
                                  text: '24',
                                  color: Colors.white,
                                  fSize: 18.0,
                                  fWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Image.asset(
                              AppImages.left,
                              fit: BoxFit.cover,
                            ),
                            Positioned.fill(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textWidget(
                                    textAlign: TextAlign.center,
                                    text: 'Total Monthly Appointments',
                                    color: Colors.white,
                                    fSize: 10.0,
                                    fWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  textWidget2(
                                    textAlign: TextAlign.center,
                                    text: '132',
                                    color: Colors.white,
                                    fSize: 18.0,
                                    fWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      width: 220,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppImages.doctor1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWidget(
                                      text: 'Dr. Michael Pole ',
                                      fSize: 15.0,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    textWidget(
                                      text: 'Cardiology,Orthopedics',
                                      fSize: 10.0,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    textWidget(
                                      text: 'Neurology,Pediatrics',
                                      fSize: 10.0,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              height: 35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ConsultantDetails(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    textWidget(text: 'Details', fSize: 13.0),
                                    Icon(Icons.arrow_right_alt)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
