import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:appointment_management/src/views/notifications/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      const Duration(hours: 10),
      const Duration(hours: 16),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            child: Image.asset(
              AppImages.notification,
              width: 50,
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
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
                      const SizedBox(
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
                                const SizedBox(
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
                        const SizedBox(
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
                                  const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 6,
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
                            decoration: const BoxDecoration(
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
            Expanded(
              flex: 4,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppImages.doctor1,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                        text: 'Dr. Michael Pole ',
                                        fSize: 15.0,
                                        fWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const RatingWidget(
                                        initialRating: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 120,
                              // height: 35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const ConsultantDetails(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    textWidget(text: 'Details', fSize: 13.0),
                                    const Icon(Icons.arrow_right_alt)
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

class RatingWidget extends StatelessWidget {
  final double? initialRating;
  const RatingWidget({
    this.initialRating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      // width: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 30,
            child: Container(
              height: 30,
              padding: const EdgeInsets.only(left: 20, right: 5),
              decoration: const BoxDecoration(
                color: AppColors.ratingbarColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              alignment: Alignment.center,
              child: RatingBar.builder(
                updateOnDrag: true,
                glowColor: AppColors.starColor,
                glowRadius: 5.0,
                initialRating: initialRating ?? 5.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 14,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.starColor,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: textWidget(
                text: initialRating.toString(),
                fSize: 16,
                fWeight: FontWeight.w600,
                color: AppColors.buttonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
