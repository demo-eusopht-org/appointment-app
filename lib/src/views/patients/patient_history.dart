import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/patients/view_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/text_widget.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
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
        title: 'Patient History',
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            AppImages.vectorPatient,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(18),
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
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.patient,
                          height: 100,
                        ),
                        Expanded(
                          child: GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 1.0,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _buildDetails('Patient Name', 'Abid Ali'),
                              _buildDetails('Height', '5.7'),
                              _buildDetails('Age', '24'),
                              _buildDetails('Email Address', 'Abid@gmail.com'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 156,
                  // height: 33,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.buttonColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget2(
                          text: 'Total Visits',
                          fWeight: FontWeight.w600,
                          fSize: 12.0,
                          color: Colors.white,
                        ),
                        textWidget2(
                          text: '9',
                          fWeight: FontWeight.w700,
                          fSize: 16.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 156,
                  // height: ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.buttonColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget2(
                          text: 'This Month',
                          fWeight: FontWeight.w600,
                          fSize: 12.0,
                          color: Colors.white,
                        ),
                        textWidget2(
                          text: '4',
                          fWeight: FontWeight.w700,
                          fSize: 16.0,
                          color: Colors.white,
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
              height: 30,
              // width: 360,
              color: AppColors.buttonColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: textWidget2(
                          text: 'Consultant Name',
                          fSize: 9.0,
                          fWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: textWidget2(
                          text: 'Date',
                          fSize: 9.0,
                          fWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: textWidget2(
                          text: 'Time',
                          fSize: 9.0,
                          fWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: textWidget2(
                                      text: 'Dr.Smith',
                                      fSize: 10.0,
                                      fWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      backgroundColor: AppColors.buttonColor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: textWidget2(
                                    text: '15/1/24',
                                    fSize: 10,
                                    fWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: textWidget(
                                    text: '8:33PM',
                                    fSize: 10,
                                    fWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 89,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ViewDetails(),
                                        ),
                                      );
                                    },
                                    child: textWidget2(
                                      text: 'View Details',
                                      fSize: 6.0,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(47),
                                      ),
                                      backgroundColor: AppColors.buttonColor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(),
                      ],
                    );
                  }),
            )
          ],
        ),
      ]),
    );
  }

  Widget _buildDetails(String text, String label) {
    return Column(
      children: [
        textWidget(
          text: text,
          fSize: 10.0,
          fWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: textWidget(
              text: label,
              fSize: 10.0,
              fWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ],
    );
  }
}
