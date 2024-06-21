import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/views/customer/add_customer.dart';
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

  dynamic user, businessId;

  List<Appointment>? allAppointments;

  bool isLoading = false;

  User? userData;

  @override
  void initState() {
    _init();
    super.initState();
  }

  bool isBooked = false;
  bool isConducted = false;
  bool isCancelled = false;
  List<Appointment> isBookedList = [];
  List<Appointment> isConductedList = [];
  List<Appointment> isCancelledList = [];

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
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Appointments',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
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
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget(
                      text: 'Schedule',
                      fWeight: FontWeight.w800,
                      fSize: 12.0,
                      color:
                          selectedIndex == 0 ? Colors.white : AppColors.primary,
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
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget(
                      text: 'Completed',
                      fWeight: FontWeight.w800,
                      fSize: 12.0,
                      color:
                          selectedIndex == 1 ? Colors.white : AppColors.primary,
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
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget(
                      text: 'Cancelled',
                      fSize: 12.0,
                      fWeight: FontWeight.w800,
                      color:
                          selectedIndex == 2 ? Colors.white : AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // selectedIndex == 0
          //     ? Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             textWidget(
          //               text: 'Febuary 15, 2024',
          //               fSize: 14.0,
          //               fWeight: FontWeight.w500,
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                 color: AppColors.todayBoxColor,
          //                 borderRadius: BorderRadius.circular(3),
          //               ),
          //               width: 70,
          //               height: 30,
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   textWidget(
          //                     text: 'Today',
          //                     fSize: 10.0,
          //                     fWeight: FontWeight.w400,
          //                   ),
          //                   Icon(
          //                     Icons.keyboard_arrow_down_outlined,
          //                     size: 16,
          //                     color: Colors.black,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     : SizedBox(),
          // selectedIndex == 1
          //     ? Align(
          //         alignment: Alignment.centerRight,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 12),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: AppColors.todayBoxColor,
          //               borderRadius: BorderRadius.circular(3),
          //             ),
          //             width: 90,
          //             height: 30,
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 textWidget(
          //                   text: 'Last 7 days',
          //                   fSize: 10.0,
          //                   fWeight: FontWeight.w400,
          //                 ),
          //                 Icon(
          //                   Icons.keyboard_arrow_down_outlined,
          //                   size: 16,
          //                   color: Colors.black,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //     : SizedBox(),
          // SizedBox(height: 20),

          isLoading
              ? const Loader()
              : selectedIndex == 0
                  ? !isBooked
                      ? Center(
                          child: textWidget(
                            text: 'No Schedule Appointments found',
                            fWeight: FontWeight.w700,
                          ),
                        )
                      : ScheduleList(
                          allAppointments: isBookedList,
                        )
                  : selectedIndex == 1
                      ? !isConducted
                          ? Center(
                              child: textWidget(
                                text: 'No Completed Appointments found',
                                fWeight: FontWeight.w700,
                              ),
                            )
                          : ScheduleList(
                              allAppointments: isConductedList,
                            )
                      : SizedBox(),

          selectedIndex == 2
              ? !isCancelled
                  ? Center(
                      child: textWidget(
                        text: 'No Cancelled Appointments found',
                        fWeight: FontWeight.w700,
                      ),
                    )
                  : ScheduleList(
                      allAppointments: isCancelledList,
                    )
              : SizedBox()
          //     : selectedIndex == 1
          //         ? CompletedList()
          //         : SizedBox(),
          // selectedIndex == 2 ? CancelList() : SizedBox()
        ],
      ),
    );
  }

  Future<void> _init() async {
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    setState(() {
      isLoading = true;
    });

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
