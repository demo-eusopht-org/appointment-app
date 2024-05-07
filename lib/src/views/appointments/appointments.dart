import 'package:appointment_management/src/views/widgets/cancel_list.dart';
import 'package:appointment_management/src/views/widgets/completed_list.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/schedule_list.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Appointments',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            height: 61,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? AppColors.buttonColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget2(
                      text: 'Schedule',
                      fWeight: FontWeight.w800,
                      fSize: 12.0,
                      color: selectedIndex == 0
                          ? Colors.white
                          : AppColors.buttonColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? AppColors.buttonColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget2(
                      text: 'Completed',
                      fWeight: FontWeight.w800,
                      fSize: 12.0,
                      color: selectedIndex == 1
                          ? Colors.white
                          : AppColors.buttonColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == 2
                          ? AppColors.buttonColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget2(
                      text: 'Cancel',
                      fSize: 12.0,
                      fWeight: FontWeight.w800,
                      color: selectedIndex == 2
                          ? Colors.white
                          : AppColors.buttonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          selectedIndex == 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                        text: 'Febuary 15, 2024',
                        fSize: 14.0,
                        fWeight: FontWeight.w500,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.todayBoxColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        width: 70,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textWidget2(
                              text: 'Today',
                              fSize: 10.0,
                              fWeight: FontWeight.w400,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 16,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          selectedIndex == 1
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.todayBoxColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      width: 90,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget2(
                            text: 'Last 7 days',
                            fSize: 10.0,
                            fWeight: FontWeight.w400,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20),
          selectedIndex == 0
              ? ScheduleList()
              : selectedIndex == 1
                  ? CompletedList()
                  : SizedBox(),
          selectedIndex == 2 ? CancelList() : SizedBox()
        ],
      ),
    );
  }
}
