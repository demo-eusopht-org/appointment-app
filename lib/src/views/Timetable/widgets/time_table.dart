import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Timetable/custom_now_indicator.dart';
import 'package:appointment_management/src/views/Timetable/widgets/drag_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetable/timetable.dart';

// ignore: must_be_immutable
class CustomTimeTable extends StatefulWidget {
  List<Appointment> allAppointments;
  CustomTimeTable({super.key, required this.allAppointments});

  @override
  State<CustomTimeTable> createState() => _CustomTimeTableState();
}

class _CustomTimeTableState extends State<CustomTimeTable> {
  // final selectedRange = ValueNotifier<DateTimeRange?>(null);

  final _dateController = DateController(
    initialDate: DateTimeTimetable.today(),
    visibleRange: VisibleDateRange.week(
      startOfWeek: DateTime.monday,
    ),
  );

  final _timeController = TimeController(
    initialRange: TimeRange(
      const Duration(hours: 8),
      const Duration(hours: 19),
    ),
    minDuration: const Duration(hours: 5),
  );

  List<Appointment> appointments = [];
  
  @override
  void initState() {
    appointments = widget.allAppointments;
    print('appointments ${appointments.length}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TimetableConfig<Appointment>(
      dateController: _dateController,
      timeController: _timeController,
      eventProvider: (visibleRange) {
        if (kDebugMode) {
          log('${'testing time 1 ${visibleRange}'}');
        }

        return appointments;
    
        // return events.where((Appointment appointment) {
        //   return appointment.start.isAfter(visibleRange.start) &&
        //       appointment.end.isBefore(visibleRange.end);
        // })
        //     // .map(
        //     //   (e) => e.copyWith(
        //     //     start: e.start.copyWith(isUtc: true),
        //     //     end: e.end.copyWith(isUtc: true),
        //     //   ),
        //     // )
        //     .toList();
      },
      eventBuilder: (context, event) {
        print(
            'testing time ${event.scheduleTime!.fromStringtoFormattedTime()}');
    
        return InkWell(
          onTap: () {
            // Navigator.push(
            // context,
            // CupertinoPageRoute(
            //   builder: (context) => TaskDetails(
            //     evnetModel: event,
            //   ),
            // ),
            // );
          },
          child: Container(
              alignment: Alignment.center,
              color: AppColors.primary,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      // text: event.start
                      //     .copyWith(isUtc: true)
                      //     .getShortFormattedDate(),
                      text: 'hello11',
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 9,
                      ),
                    ),
                    TextSpan(
                      // text: event.end
                      //     .add(const Duration(minutes: 30))
                      //     .copyWith(isUtc: true)
                      //     .getShortFormattedDate(),
                      text: 'hello',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      callbacks: TimetableCallbacks(
        onDateTap: (date) {},
        onDateBackgroundTap: (date) {},
        onDateTimeBackgroundTap: (dateTime) {},
      ),
      theme: _getTimeTableThemeData(context),
      child: MultiDateTimetable(
        contentBuilder: (context, onLeadingWidthChanged) {
          return MultiDateTimetableContent(
            content: TimeZoom(
              child: HourDividers(
                style: HourDividersStyle(context,
                    color: AppColors.primary,
                    // width: kDebugMode ? 2 : 0.5,
                    width: 0.5),
                child: DateDividers(
                  style: DateDividersStyle(context,
                      color: AppColors.primary,
                      // width: kDebugMode ? 2 : 0.5,
                      width: 0.5),
                  child: CustomNowIndicator(
                    color: AppColors.primary,
                    // child: LayoutBuilder(
                    //   builder: (context, constraints) {
                    //     return _buildPartDayEvent(constraints);
                    //   },
                    // ),
                  ),
                ),
              ),
            ),
            divider: const SizedBox.shrink(),
          );
        },
        headerBuilder: (context, leadingWidth) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              left: leadingWidth ?? 45,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DatePageView(
                  shrinkWrapInCrossAxis: true,
                  builder: (context, date) {
                    return Column(
                      children: [
                        Text(
                          date.getShortWeekDay(),
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          DateFormat('dd.MM.yyyy').format(date),
                          style: const TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _buildPartDayEvent(BoxConstraints constraints) {
  //   return ValueListenableBuilder(
  //     valueListenable: selectedRange,
  //     builder: (context, range, child) {
  //       return Stack(
  //         children: [
  //           _buildEventsPageView(
  //             context,
  //             _dateController,
  //             constraints.smallest,
  //           ),
  //           if (range != null)
  //             TimePicker(
  //               onTap: () {
  //                 if (widget.selectDateTime != null) {
  //                   widget.selectDateTime!(range);
  //                   Navigator.pop(context);
  //                 }
  //                 selectedRange.value = null;
  //               },
  //               onDateRangeChanged: (range) {
  //                 // Prevent selecting past dates
  //                 if (range.start.isBefore(DateTime.now())) {
  //                   selectedRange.value = null;
  //                 } else {
  //                   selectedRange.value = range;
  //                 }
  //               },
  //               width: constraints.maxWidth / 7,
  //               dateController: _dateController,
  //               timeController: _timeController,
  //               parentHeight: constraints.minHeight,
  //               initialDateRange: DateTimeRange(
  //                 start: range.start,
  //                 end: range.end,
  //               ),
  //             ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget _buildPartDayEvent(BoxConstraints constraints) {
  //   return ValueListenableBuilder(
  //     valueListenable: selectedRange,
  //     builder: (context, range, child) {
  //       return Stack(
  //         children: [
  //           _buildEventsPageView(
  //             context,
  //             _dateController,
  //             constraints.smallest,
  //           ),
  //           if (range != null)
  //             TimePicker(
  //               onTap: () {
  //                 if (widget.selectDateTime != null) {
  //                   widget.selectDateTime!(range);
  //                   Navigator.pop(context);
  //                 }
  //                 selectedRange.value = null;
  //               },
  //               onDateRangeChanged: (range) {
  //                 // Prevent selecting past dates
  //                 if (range.start.isBefore(DateTime.now())) {
  //                   selectedRange.value = null;
  //                 } else {
  //                   selectedRange.value = range;
  //                 }
  //               },
  //               width: constraints.maxWidth / 7,
  //               dateController: _dateController,
  //               timeController: _timeController,
  //               parentHeight: constraints.minHeight,
  //               initialDateRange: DateTimeRange(
  //                 start: range.start,
  //                 end: range.end,
  //               ),
  //             ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildEventsPageView(
    BuildContext context,
    DateController dateController,
    Size size,
  ) {
    final overlaysController = DefaultTimeOverlayProvider.of(context);
    return DragInfo(
      size: size,
      context: context,
      dateController: dateController,
      child: DatePageView(
        controller: dateController,
        builder: (_, date) {
          final eventProvider = DefaultEventProvider.of<Appointment>(context);
          final events = eventProvider?.call(date.fullDayInterval) ?? [];

          return DateContent<Appointment>(
            date: date,
            events: events,
            onBackgroundTap: (date) async {
              // if (widget.fromCreateScreen) {
              //   // Prevent selecting past dates
              //   if (date.isBefore(DateTime.now())) {
              //     return;
              //   }

              //   selectedRange.value = null;
              //   await Future.delayed(const Duration(milliseconds: 10));
              //   selectedRange.value = DateTimeRange(
              //     start: date,
              //     end: date.add(
              //       const Duration(hours: 1),
              //     ),
              //   );
              // }
            },
            overlays: overlaysController?.call(context, date) ?? [],
          );
        },
      ),
    );
  }
}

TimetableThemeData _getTimeTableThemeData(BuildContext context) {
  return TimetableThemeData(
    context,
    dateEventsStyleProvider: (date) => DateEventsStyle(
      context,
      date,
      enableStacking: false,
    ),
    dateDividersStyle: DateDividersStyle(
      context,
      color: Colors.blue,
    ),
    hourDividersStyle: HourDividersStyle(
      context,
      color: Colors.yellow,
    ),
    weekdayIndicatorStyleProvider: (date) => WeekdayIndicatorStyle(
      context,
      date,
    ),
    dateHeaderStyleProvider: (date) => DateHeaderStyle(
      context,
      date,
      showWeekdayIndicator: true,
    ),
    weekIndicatorStyleProvider: (week) => WeekIndicatorStyle(
      context,
      week,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      labels: [week.weekOfYear.toString()],
    ),
    timeIndicatorStyleProvider: (time) => TimeIndicatorStyle(
      context,
      time,
      alwaysUse24HourFormat: true,
      label: time.getFormattedHoursTime(),
    ),
  );
}


//Adding month and year dropdown selector 

// import 'dart:developer';

// import 'package:appointment_management/model/appointment/get_all_appointment.dart';
// import 'package:appointment_management/src/resources/app_colors.dart';
// import 'package:appointment_management/src/utils/extensions.dart';
// import 'package:appointment_management/src/views/Timetable/custom_now_indicator.dart';
// import 'package:appointment_management/src/views/Timetable/widgets/drag_info.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:timetable/timetable.dart';

// class CustomTimeTable extends StatefulWidget {
//   final List<Appointment> allAppointments;

//   const CustomTimeTable({Key? key, required this.allAppointments}) : super(key: key);

//   @override
//   State<CustomTimeTable> createState() => _CustomTimeTableState();
// }

// class _CustomTimeTableState extends State<CustomTimeTable> with SingleTickerProviderStateMixin {
//   final _dateController = DateController(
//     initialDate: DateTimeTimetable.today(),
//     visibleRange: VisibleDateRange.week(
//       startOfWeek: DateTime.monday,
//     ),
//   );

//   final _timeController = TimeController(
//     initialRange: TimeRange(
//       const Duration(hours: 8),
//       const Duration(hours: 19),
//     ),
//     minDuration: const Duration(hours: 5),
//   );

//   List<Appointment> appointments = [];

//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;

//   @override
//   void initState() {
//     appointments = widget.allAppointments;
//     print('appointments ${appointments.length}');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButton<int>(
//                 value: selectedYear,
//                 items: List.generate(100, (index) {
//                   int year = DateTime.now().year - 50 + index;
//                   return DropdownMenuItem(
//                     value: year,
//                     child: Text(year.toString()),
//                   );
//                 }),
//                 onChanged: (value) {
//                   setState(() {
//                     if (value != null) {
//                       selectedYear = value;
//                       _dateController.animateTo(
//                         DateTime(selectedYear, selectedMonth, 1),
//                         vsync: this,
//                       );
//                     }
//                   });
//                 },
//               ),
//               const SizedBox(width: 10),
//               DropdownButton<int>(
//                 value: selectedMonth,
//                 items: List.generate(12, (index) {
//                   int month = index + 1;
//                   return DropdownMenuItem(
//                     value: month,
//                     child: Text(DateFormat.MMMM().format(DateTime(0, month))),
//                   );
//                 }),
//                 onChanged: (value) {
//                   setState(() {
//                     if (value != null) {
//                       selectedMonth = value;
//                       _dateController.animateTo(
//                         DateTime(selectedYear, selectedMonth, 1),
//                         vsync: this,
//                       );
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: TimetableConfig<Appointment>(
//             dateController: _dateController,
//             timeController: _timeController,
//             eventProvider: (visibleRange) {
//               if (kDebugMode) {
//                 log('${'testing time 1 ${visibleRange}'}');
//               }
//               return appointments;
//             },
//             eventBuilder: (context, event) {
//               print(
//                   'testing time ${event.scheduleTime!.fromStringtoFormattedTime()}');
//               return InkWell(
//                 onTap: () {
//                   // Navigator.push(
//                   // context,
//                   // CupertinoPageRoute(
//                   //   builder: (context) => TaskDetails(
//                   //     eventModel: event,
//                   //   ),
//                   // ),
//                   // );
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   color: AppColors.primary,
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           // text: event.start
//                           //     .copyWith(isUtc: true)
//                           //     .getShortFormattedDate(),
//                           text: 'hello11',
//                           style: const TextStyle(
//                             color: AppColors.black,
//                             fontSize: 9,
//                           ),
//                         ),
//                         TextSpan(
//                           // text: event.end
//                           //     .add(const Duration(minutes: 30))
//                           //     .copyWith(isUtc: true)
//                           //     .getShortFormattedDate(),
//                           text: 'hello',
//                           style: const TextStyle(
//                             color: AppColors.white,
//                             fontSize: 9,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//             callbacks: TimetableCallbacks(
//               onDateTap: (date) {},
//               onDateBackgroundTap: (date) {},
//               onDateTimeBackgroundTap: (dateTime) {},
//             ),
//             theme: _getTimeTableThemeData(context),
//             child: MultiDateTimetable(
//               contentBuilder: (context, onLeadingWidthChanged) {
//                 return MultiDateTimetableContent(
//                   content: TimeZoom(
//                     child: HourDividers(
//                       style: HourDividersStyle(context,
//                           color: AppColors.primary,
//                           // width: kDebugMode ? 2 : 0.5,
//                           width: 0.5),
//                       child: DateDividers(
//                         style: DateDividersStyle(context,
//                             color: AppColors.primary,
//                             // width: kDebugMode ? 2 : 0.5,
//                             width: 0.5),
//                         child: CustomNowIndicator(
//                           color: AppColors.primary,
//                           // child: LayoutBuilder(
//                           //   builder: (context, constraints) {
//                           //     return _buildPartDayEvent(constraints);
//                           //   },
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   divider: const SizedBox.shrink(),
//                 );
//               },
//               headerBuilder: (context, leadingWidth) {
//                 return Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.only(
//                     left: leadingWidth ?? 45,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       DatePageView(
//                         shrinkWrapInCrossAxis: true,
//                         builder: (context, date) {
//                           return Column(
//                             children: [
//                               Text(
//                                 date.getShortWeekDay(),
//                                 style: const TextStyle(
//                                   fontSize: 11,
//                                 ),
//                               ),
//                               Text(
//                                 DateFormat('dd.MM.yyyy').format(date),
//                                 style: const TextStyle(
//                                   fontSize: 8,
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEventsPageView(
//     BuildContext context,
//     DateController dateController,
//     Size size,
//   ) {
//     final overlaysController = DefaultTimeOverlayProvider.of(context);
//     return DragInfo(
//       size: size,
//       context: context,
//       dateController: dateController,
//       child: DatePageView(
//         controller: dateController,
//         builder: (_, date) {
//           final eventProvider = DefaultEventProvider.of<Appointment>(context);
//           final events = eventProvider?.call(date.fullDayInterval) ?? [];

//           return DateContent<Appointment>(
//             date: date,
//             events: events,
//             onBackgroundTap: (date) async {
//               // if (widget.fromCreateScreen) {
//               //   // Prevent selecting past dates
//               //   if (date.isBefore(DateTime.now())) {
//               //     return;
//               //   }

//               //   selectedRange.value = null;
//               //   await Future.delayed(const Duration(milliseconds: 10));
//               //   selectedRange.value = DateTimeRange(
//               //     start: date,
//               //     end: date.add(
//               //       const Duration(hours: 1),
//               //     ),
//               //   );
//               // }
//             },
//             overlays: overlaysController?.call(context, date) ?? [],
//           );
//         },
//       ),
//     );
//   }

//   TimetableThemeData _getTimeTableThemeData(BuildContext context) {
//     return TimetableThemeData(
//       context,
//       dateEventsStyleProvider: (date) => DateEventsStyle(
//         context,
//         date,
//         enableStacking: false,
//       ),
//       dateDividersStyle: DateDividersStyle(
//         context,
//         color: Colors.blue,
//       ),
//       hourDividersStyle: HourDividersStyle(
//         context,
//         color: Colors.yellow,
//       ),
//       weekdayIndicatorStyleProvider: (date) => WeekdayIndicatorStyle(
//         context,
//         date,
//       ),
//       dateHeaderStyleProvider: (date) => DateHeaderStyle(
//         context,
//         date,
//         showWeekdayIndicator: true,
//       ),
//       weekIndicatorStyleProvider: (week) => WeekIndicatorStyle(
//         context,
//         week,
//         decoration: BoxDecoration(
//           color: Colors.green,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         labels: [week.weekOfYear.toString()],
//       ),
//       timeIndicatorStyleProvider: (time) => TimeIndicatorStyle(
//         context,
//         time,
//         alwaysUse24HourFormat: true,
//         label: time.getFormattedHoursTime(),
//       ),
//     );
//   }
// }
