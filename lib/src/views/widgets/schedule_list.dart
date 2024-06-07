import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/widgets/confirmation_dialogue.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ScheduleList extends StatefulWidget {
  List<Appointment> allAppointments;
  ScheduleList({super.key, required this.allAppointments});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  List<Customer>? customer;
  List<Consultant>? consultants;

  @override
  void initState() {
    consultants = GetLocalData.getConsultants();
    customer = GetLocalData.getCustomers();
    super.initState();
  }

  bool get isBooked => widget.allAppointments
      .any((element) => element.status!.toLowerCase() == 'booked');
  bool get isConducted => widget.allAppointments
      .any((element) => element.status!.toLowerCase() == 'conducted');
  bool get isCancelled => widget.allAppointments
      .any((element) => element.status!.toLowerCase() == 'cancelled');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.allAppointments.length,
        itemBuilder: (context, index) {
          Appointment appointment = widget.allAppointments[index];
          Customer currentCustomer = getCurrentCustomer(appointment);

          Consultant currentConsultant = getCurrentConsultant(appointment);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.sp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              child: Image.asset(AppImages.men),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textWidget(
                                      text: appointment.appointmentDate!
                                          .toMonthNameFormat()
                                          .getMonth(),
                                      fSize: 7.sp,
                                      color: Colors.white,
                                      fWeight: FontWeight.w800,
                                    ),
                                    textWidget(
                                      text: appointment.appointmentDate!
                                          .toMonthNameFormat()
                                          .getDay(),
                                      fSize: 7.sp,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                      ),
                                      child: textWidget(
                                        text: currentCustomer.name!
                                            .toUpperCaseFirst(),
                                        fSize: 12.sp,
                                        fWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                      ),
                                      child: textWidget(
                                        text: 'Consultant:',
                                        fSize: 10.sp,
                                        fWeight: FontWeight.w600,
                                        textOverFlow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                      ),
                                      child: textWidget(
                                        text: currentConsultant.name!
                                            .toUpperCaseFirst(),
                                        fSize: 12.sp,
                                        fWeight: FontWeight.w600,
                                        textOverFlow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isBooked)
                          Row(
                            children: [
                              customeButton(title: 'Reschedule', onTap: () {}),
                              SizedBox(
                                width: 5.sp,
                              ),
                              customeButton(
                                  title: 'Cancel',
                                  onTap: () async {
                                    final result = await showModalBottomSheet(
                                      enableDrag: true,
                                      context: context,
                                      builder: (context) {
                                        return const ConfirmationDialogue(
                                          message:
                                              'Are you sure you want to cancel your appointment?',
                                        );
                                      },
                                    );

                                    if (result ?? false) {}
                                  }),
                            ],
                          ),
                        if (isConducted)
                          Row(
                            children: [
                              textWidget(
                                text: 'Completed',
                                fSize: 12.sp,
                                color: Colors.green,
                                fWeight: FontWeight.w800,
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            ],
                          ),
                        if (isCancelled)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textWidget(
                                  text: 'Cancelled',
                                  fSize: 12.sp,
                                  color: Colors.red,
                                  fWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          textWidget(
                            text: appointment.scheduleTime!
                                .fromStringtoFormattedTime(),
                            fSize: 8.sp,
                            fWeight: FontWeight.w800,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  GestureDetector customeButton(
      {required String title, required Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 7.sp,
          horizontal: 7.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: title == 'Reschedule' ? AppColors.primary : AppColors.danger,
        ),
        child: textWidget(
          text: title,
          fSize: 10.sp,
          fWeight: FontWeight.w800,
          color: AppColors.white,
        ),
      ),
    );
  }

  Customer getCurrentCustomer(Appointment appointment) {
    return customer!
        .where((element) => element.id == appointment.customerId)
        .first;
  }

  Consultant getCurrentConsultant(Appointment appointment) {
    return consultants!
        .where((element) => element.id == appointment.consultantId)
        .first;
  }
}
