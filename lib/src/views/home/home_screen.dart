import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timetable/timetable.dart';

import '../../resources/app_colors.dart';
import '../Consultant/consultant_details.dart';
import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _timeController = TimeController(
    initialRange: TimeRange(
      Duration(hours: 10),
      Duration(hours: 16),
    ),
  );
  final List<Map<String, String>> popularLocations = [
    {'name': 'New York', 'image': AppImages.doctor1},
  ];
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        title: 'Hi, Ali!',
        leadingIcon: Image.asset(
          AppImages.menuIcon,
        ),
        leadingIconOnTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
        action: [
          Image.asset(
            AppImages.notification,
            width: 50,
          ),
        ],
      ),
      drawer: CustomDrawer(),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: TimetableConfig<BasicEvent>(
                  timeController: _timeController,
                  eventProvider: (date) {
                    if (date.start.isToday) {
                      final dates = DateTime.now();
                      return [
                        BasicEvent(
                          id: 1,
                          title: "Abid",
                          backgroundColor: AppColors.buttonColor,
                          start: dates.copyWith(
                            hour: 14,
                            minute: 0,
                            second: 0,
                            millisecond: 0,
                            isUtc: true,
                          ),
                          end: dates.copyWith(
                            hour: 16,
                            minute: 0,
                            second: 0,
                            millisecond: 0,
                            isUtc: true,
                          ),
                        ),
                      ];
                    }

                    return [];
                  },
                  // allDayEventBuilder: (context, event, info) {
                  //   return BasicAllDayEventWidget(event, info: info);
                  // },
                  // allDayOverflowBuilder: (context, _, __) {
                  //   return SizedBox.shrink();
                  // },
                  eventBuilder: (context, event) => BasicEventWidget(event),
                  child: MultiDateTimetable<BasicEvent>(
                    headerBuilder: (context, _) {
                      return Container(
                        height: 60,
                        color: AppColors.todayBoxColor,
                        child: MultiDateTimetableHeader<BasicEvent>(
                          dateHeaderBuilder: (context, date) {
                            return Column(
                              children: [
                                textWidget(
                                  text: DateFormat('EEE').format(date),
                                  fSize: 13.0,
                                  fWeight: FontWeight.w700,
                                ),
                                textWidget(
                                  text: date.day.toString(),
                                  fSize: 13.0,
                                  fWeight: FontWeight.w700,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  theme: TimetableThemeData(context,
                      multiDateEventHeaderStyle: MultiDateEventHeaderStyle(
                        context,
                        eventHeight: 10,
                      ),
                      dateEventsStyleProvider: (date) => DateEventsStyle(
                            context,
                            date,
                            enableStacking: false,
                          ),
                      dateDividersStyle: DateDividersStyle(
                        context,
                        color: Colors.grey,
                      ),
                      hourDividersStyle: HourDividersStyle(
                        context,
                        color: Colors.grey,
                      ),
                      weekdayIndicatorStyleProvider: (date) =>
                          WeekdayIndicatorStyle(
                            context,
                            date,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                      dateHeaderStyleProvider: (date) => DateHeaderStyle(
                            context,
                            date,
                            showWeekdayIndicator: true,
                            indicatorSpacing: 5.0,
                          ),
                      dateIndicatorStyleProvider: (date) => DateIndicatorStyle(
                            context,
                            date,
                            textStyle: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                      weekIndicatorStyleProvider: (week) => WeekIndicatorStyle(
                            context,
                            week,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                            labels: [week.weekOfYear.toString()],
                          ),
                      timeIndicatorStyleProvider: (time) => TimeIndicatorStyle(
                            context,
                            time,
                            alwaysUse24HourFormat: true,
                          )),
                ),
              ),
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
