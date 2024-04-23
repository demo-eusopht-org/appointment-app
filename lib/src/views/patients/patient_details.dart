import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:appointment_management/src/views/patients/patient_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';
import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/custom_container_patient.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  List<String> monthTexts = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
  List<String> timeTexts = ['09:00', '11:00', '02:00', '03:00', '11:00'];

  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
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
        title: 'Patient Details ',
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              AppImages.vectorBox,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 154,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: Image.asset(
                          fit: BoxFit.contain,
                          AppImages.patient,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                            text: 'Abid Ali ',
                            fSize: 20.0,
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          textWidget2(
                            text: 'Email Address:',
                            fSize: 12.0,
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textWidget(
                            text: 'Abid@gmail.com',
                            fSize: 16.0,
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                width: 66,
                                height: 47,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        textWidget2(
                                          text: 'Mobile No.',
                                          fSize: 9.0,
                                          fWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        textWidget2(
                                          text: '0323456780',
                                          fSize: 9.0,
                                          fWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                width: 66,
                                height: 47,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        textWidget2(
                                          text: 'Reference ',
                                          fSize: 9.0,
                                          fWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        textWidget2(
                                          text: '012f34',
                                          fSize: 9.0,
                                          fWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 167,
                          height: 41,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.buttonColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget2(
                                text: 'Address',
                                fWeight: FontWeight.w600,
                                fSize: 10.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              textWidget2(
                                text: '123 Main Street, Anytown, USA 12345',
                                fWeight: FontWeight.w500,
                                fSize: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => PatientHistory(),
                              ),
                            );
                          },
                          child: Container(
                            width: 167,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.buttonColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textWidget2(
                                  text: 'Patient Details ',
                                  fWeight: FontWeight.w800,
                                  fSize: 17.0,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                          text: 'Note:',
                          fSize: 18.0,
                          fWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        textWidget2(
                          text:
                              'Ive been making efforts to stay active and eat healthier to improve my overall well-being.',
                          fSize: 15.0,
                          fWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        // textWidget2(
                        //   text: 'health, from infancy to adolescence.',
                        //   fSize: 15.0,
                        //   fWeight: FontWeight.w600,
                        //   color: Colors.black,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInfoContainer(
                          label: 'Age:',
                          value: '24',
                          color: AppColors.buttonColor,
                          height: MediaQuery.of(context).size.width * 0.065,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInfoContainer(
                          label: 'Height:',
                          value: '5.7',
                          color: AppColors.buttonColor,
                          height: MediaQuery.of(context).size.width * 0.067,
                          width: MediaQuery.of(context).size.width * 0.33,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInfoContainer(
                          label: 'D.O.B:',
                          value: '1/8/2000',
                          color: AppColors.buttonColor,
                          height: MediaQuery.of(context).size.width * 0.069,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(
                              text: 'Schedule',
                              fSize: 18.0,
                              fWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 62,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              bool isSelected = (index == selectedDateIndex);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDateIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 62,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: isSelected
                                          ? AppColors.buttonColor
                                          : AppColors.ratingbarColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textWidget(
                                          text: monthTexts[index],
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fSize: 18.0,
                                          fWeight: FontWeight.w800,
                                        ),
                                        textWidget(
                                          text: '29',
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fSize: 18.0,
                                          fWeight: FontWeight.w800,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                          text: 'Time ',
                          fSize: 18.0,
                          fWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 62,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              bool isSelected = (index == selectedTimeIndex);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTimeIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 62,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: isSelected
                                          ? AppColors.buttonColor
                                          : AppColors.ratingbarColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textWidget(
                                          text: timeTexts[index],
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fSize: 18.0,
                                          fWeight: FontWeight.w800,
                                        ),
                                        textWidget(
                                          text: 'AM',
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fSize: 18.0,
                                          fWeight: FontWeight.w800,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      print('heelo');
                    },
                    child: Stack(
                      children: [
                        Image.asset(AppImages.button),
                        Positioned.fill(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.white, AppColors.buttonColor],
                                stops: [0.4, 0.4], // Halfway
                              ).createShader(bounds);
                            },
                            child: Center(
                              child: textWidget2(
                                textAlign: TextAlign.center,
                                text: 'Book Appointment',
                                color: Colors.white,
                                fSize: 17.0,
                                fWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
