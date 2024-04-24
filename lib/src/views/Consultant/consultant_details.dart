import 'package:appointment_management/src/views/appointments/appointment_booking_doctor.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';
import '../auth/widgets/custom_appbar.dart';

class ConsultantDetails extends StatefulWidget {
  const ConsultantDetails({super.key});

  @override
  State<ConsultantDetails> createState() => _ConsultantDetailsState();
}

class _ConsultantDetailsState extends State<ConsultantDetails> {
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
        title: 'Consultant Details ',
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
                          AppImages.doctor1,
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
                            text: 'Dr. Michael Pole ',
                            fSize: 20.0,
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          textWidget(
                            text: 'Cardiology,Orthopedics',
                            fSize: 12.0,
                            fWeight: FontWeight.w700,
                          ),
                          textWidget(
                            text: ',Neurology,Pediatrics',
                            fSize: 12.0,
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
                                          text: 'Patients',
                                          fSize: 10.0,
                                          fWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        textWidget2(
                                          text: '2.5K',
                                          fSize: 12.0,
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
                                          text: 'Experience ',
                                          fSize: 10.0,
                                          fWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        textWidget2(
                                          text: '45 Years',
                                          fSize: 12.0,
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
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 50,
                                  child: Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: AppColors.ratingbarColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Center(
                                      child: RatingBar.builder(
                                        updateOnDrag: true,
                                        glowColor: AppColors.starColor,
                                        glowRadius: 5.0,
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 14,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: AppColors.starColor,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.buttonColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: textWidget(
                                      text: '4.0',
                                      fSize: 16,
                                      fWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 154,
                          height: 41,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.buttonColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget2(
                                text: 'Satisfied Patients',
                                fWeight: FontWeight.w600,
                                fSize: 10.0,
                                color: Colors.white,
                              ),
                              textWidget2(
                                text: '2K+',
                                fWeight: FontWeight.w600,
                                fSize: 15.0,
                                color: Colors.white,
                              ),
                            ],
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
                          text: 'About Consultant',
                          fSize: 18.0,
                          fWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textWidget2(
                          text: 'Dr. Michael Pole: Expert care for childrens',
                          fSize: 15.0,
                          fWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textWidget2(
                          text: 'health, from infancy to adolescence.',
                          fSize: 15.0,
                          fWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textWidget(
                          text: 'Services',
                          fSize: 18.0,
                          fWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                textWidget2(
                                  text: 'Check-ups',
                                  fSize: 18.0,
                                  fWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.15),
                            Row(
                              children: [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                textWidget2(
                                  text: 'Assessments',
                                  fSize: 18.0,
                                  fWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 10,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            textWidget2(
                              text: 'Vaccinations',
                              fSize: 18.0,
                              fWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.1),
                            Row(
                              children: [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                textWidget2(
                                  text: 'Guidance',
                                  fSize: 18.0,
                                  fWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 10,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            textWidget2(
                              text: 'Treatment',
                              fSize: 18.0,
                              fWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ],
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
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AppointmentBookingDoctor(),
                        ),
                      );
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
