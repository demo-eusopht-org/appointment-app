import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/Appointments/appointment_details.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/Home/appointment_widget.dart';
import 'package:appointment_management/src/views/Home/widgets/appointment_count_widget.dart';
import 'package:appointment_management/src/views/Timetable/widgets/time_table.dart';
import 'package:appointment_management/src/views/notifications/notification_screen.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timetable/timetable.dart';

import '../../resources/app_colors.dart';
import '../Consultant/consultant_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSelected = true;

  dynamic user;
  dynamic businessId;
  User? userData;

  List<Consultant> consultants = [];

  List<Appointment>? allAppointments;
  int totalappointments = 0;
  int currentMonthAppointments = 0;

  bool isBooked = false;
  bool isConducted = false;
  bool isCancelled = false;

  List<Appointment>? isBookedList;
  List<Appointment>? isConductedList;
  List<Appointment>? isCancelledList;

  bool isLoading = false;

  final _dateController = DateController(
    initialDate: DateTimeTimetable.today(),
    // visibleRange: VisibleDateRange.week(
    //   startOfWeek: DateTime.monday,
    // ),
    visibleRange: VisibleDateRange.days(5),
  );

  final _timeController = TimeController(
    initialRange: TimeRange(
      const Duration(hours: 8),
      const Duration(hours: 19),
    ),
    minDuration: const Duration(hours: 5),
  );

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        title: 'Hi, ${user!['user']['name'].toString().toUpperCaseFirst()}!',
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
      body: isLoading
          ? const Loader()
          : PopScope(
              canPop: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppointmentCountWidget(
                            title: 'Total Appointments',
                            totalappointments: isAdmin!
                                ? totalappointments.toString()
                                : allAppointments!.length.toString()),
                        AppointmentCountWidget(
                          title: 'Monthly Appointments',
                          totalappointments:
                              currentMonthAppointments.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: TimetableConfig<Appointment>(
                          timeController: _timeController,
                          dateController: _dateController,
                          eventProvider: (visibleRange) {
                            if (allAppointments!.isNotEmpty) {
                              final eventList = allAppointments!
                                  .where((Appointment appointment) {
                                final startTime =
                                    utils.mergingDateTime(appointment);
                                final endTime = utils
                                    .mergingDateTime(appointment)
                                    .add(const Duration(minutes: 30));

                                return startTime
                                            .copyWith(isUtc: true)
                                            .isAfter(visibleRange.start) &&
                                        endTime
                                            .copyWith(isUtc: true)
                                            .isBefore(visibleRange.end) &&
                                        appointment.start
                                            .isAfter(visibleRange.start) &&
                                        appointment.end
                                            .isBefore(visibleRange.end)
                                    //     &&
                                    // appointment.status!.toLowerCase() ==
                                    //     'booked'
                                    ;
                              }).map((Appointment e) {
                                return Appointment(
                                  appointmentId: e.appointmentId,
                                  // appointmentDate: e.appointmentDate,
                                  appointmentNote: e.appointmentNote,
                                  branchId: e.branchId,
                                  businessId: e.businessId,
                                  consultantId: e.consultantId,
                                  createdAt: e.createdAt,
                                  updatedAt: e.updatedAt,
                                  customerId: e.customerId,
                                  scheduleTime: e.scheduleTime,
                                  status: e.status,
                                  uidAppointment: e.uidAppointment,
                                  start: e.start.copyWith(isUtc: true),
                                  end: e.end.copyWith(isUtc: true),
                                );
                              }).toList();

                              return eventList;
                            } else {
                              return [];
                            }
                          },
                          eventBuilder: (context, appointment) =>
                              AppointmentWidget(appointment: appointment),
                          callbacks: TimetableCallbacks(
                            onDateTap: (date) {},
                            onDateBackgroundTap: (date) {},
                            onDateTimeBackgroundTap: (dateTime) {
                              final appointments =
                                  allAppointments!.where((element) {
                                return element.start
                                        .toString()
                                        .split(' ')
                                        .first ==
                                    dateTime.toString().split(' ').first;
                              }).toList();
                              final route = MaterialPageRoute(
                                builder: (context) => AppointmentDetails(
                                    appointments: appointments,
                                    onUpdate: () async {}),
                              );
                              Navigator.push(context, route);
                            },
                          ),
                          theme: TimetableThemeData(
                            context,
                            multiDateEventHeaderStyle:
                                MultiDateEventHeaderStyle(
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
                            dateIndicatorStyleProvider: (date) =>
                                DateIndicatorStyle(
                              context,
                              date,
                              textStyle: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            weekIndicatorStyleProvider: (week) =>
                                WeekIndicatorStyle(
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
                            timeIndicatorStyleProvider: (time) =>
                                TimeIndicatorStyle(
                              context,
                              time,
                              alwaysUse24HourFormat: true,
                            ),
                          ),
                          child: MultiDateTimetable<Appointment>(
                            headerBuilder: (context, _) {
                              return Container(
                                height: 60,
                                color: AppColors.todayBoxColor,
                                child: MultiDateTimetableHeader<Appointment>(
                                  dateHeaderBuilder: (context, date) {
                                    return Column(
                                      children: [
                                        textWidget(
                                          text: date
                                              .copyWith(isUtc: true)
                                              .getShortWeekDay(),
                                          fSize: 13.0,
                                          fWeight: FontWeight.w700,
                                        ),
                                        textWidget(
                                          text: date
                                              .copyWith(isUtc: true)
                                              .day
                                              .toString(),
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
                        ),
                      ),
                    ),
                    if (consultants.isNotEmpty)
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: consultants.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final consultant = consultants[index];

                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              margin: EdgeInsets.all(5.sp),
                              alignment: Alignment.center,
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5.sp),
                                          child: CircleAvatar(
                                            radius: 40.sp,
                                            backgroundImage: consultant
                                                        .imageName !=
                                                    null
                                                ? CachedNetworkImageProvider(
                                                    '${Constants.consultantImageBaseUrl}${consultant.imageName}',
                                                  )
                                                : AssetImage(AppImages.noImage)
                                                    as ImageProvider<Object>,
                                          ),
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
                                                text: consultant.name!
                                                    .toUpperCaseFirst(),
                                                fSize: 15.0,
                                                fWeight: FontWeight.w800,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              textWidget(
                                                text: '${consultant.field}',
                                                fSize: 10.sp,
                                                fWeight: FontWeight.w800,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              // const RatingWidget(
                                              //   initialRating: 2.0,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                ConsultantDetails(
                                              consultant: consultant,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: textWidget(
                                                text: 'Details', fSize: 13.0),
                                          ),
                                          const Icon(Icons.arrow_forward_ios)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else if (isAdmin!)
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: textWidget(
                            text: 'No consultants found',
                            fWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                    SizedBox(
                      height: 10.sp,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _init() async {
    setState(() {
      isLoading = true;
    });
    user = locator<LocalStorageService>().getData(key: 'user');

    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    if (isAdmin!) {
      consultants = GetLocalData.getConsultants();
    }
    userData = GetLocalData.getUser();
    await getAllAppointments();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getAllAppointments() async {
    try {
      final res = await ApiServices.getAllAppointments(
        context,
        Constants.getAllAppointments + businessId.toString(),
        user,
      );

      if (res != null) {
        totalappointments = res.totalAppointments ?? 0;
        currentMonthAppointments = res.currentMonthAppointments ?? 0;

        if (res.appointments!.isNotEmpty) {
          if (isAdmin!) {
            allAppointments = res.appointments;
          } else {
            allAppointments = res.appointments!
                .where((element) => element.consultantId == userData!.id)
                .toList();
          }

          setBoolValues();
        }
      } else {
        allAppointments = [];
      }
    } catch (e, stack) {
      log('Something went wrong in getAllAppointments Api $e',
          stackTrace: stack);
    }
  }

  void setBoolValues() {
    isBooked = allAppointments!
        .any((element) => element.status!.toLowerCase() == 'booked');
    isConducted = allAppointments!
        .any((element) => element.status!.toLowerCase() == 'conducted');
    isCancelled = allAppointments!
        .any((element) => element.status!.toLowerCase() == 'cancelled');

    isBookedList = allAppointments!
        .where((element) => element.status!.toLowerCase() == 'booked')
        .toList();
    isConductedList = allAppointments!
        .where((element) => element.status!.toLowerCase() == 'conducted')
        .toList();
    isCancelledList = allAppointments!
        .where((element) => element.status!.toLowerCase() == 'cancelled')
        .toList();
  }
}

// class RatingWidget extends StatelessWidget {
//   final double? initialRating;
//   const RatingWidget({
//     this.initialRating,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       // width: 100,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             left: 30,
//             child: Container(
//               height: 30,
//               padding: const EdgeInsets.only(left: 20, right: 5),
//               decoration: const BoxDecoration(
//                 color: AppColors.ratingbarColor,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: RatingBar.builder(
//                 updateOnDrag: true,
//                 glowColor: AppColors.starColor,
//                 glowRadius: 5.0,
//                 initialRating: initialRating ?? 5.0,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemSize: 14,
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: AppColors.starColor,
//                 ),
//                 onRatingUpdate: (rating) {
//                   print(rating);
//                 },
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             child: Container(
//               alignment: Alignment.center,
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: textWidget(
//                 text: initialRating.toString(),
//                 fSize: 16,
//                 fWeight: FontWeight.w600,
//                 color: AppColors.primary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
