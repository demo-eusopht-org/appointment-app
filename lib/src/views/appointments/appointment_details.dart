import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';

class AppointmentDetails extends StatefulWidget {
  final List<Appointment>? appointments;
  final Function onUpdate;
  const AppointmentDetails({
    super.key,
    this.appointments,
    required this.onUpdate,
  });

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  List<Appointment> appointments = [];
  @override
  void initState() {
    if (widget.appointments != null) {
      appointments = widget.appointments!;
    }

    super.initState();
  }

  bool isBooked = false;
  bool isConducted = false;
  bool isCancelled = false;

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
        title: 'Appointments Details',
      ),
      body: appointments.isEmpty
          ? Center(
              child: textWidget(
                text: 'No appointments found for this date',
                fWeight: FontWeight.w600,
              ),
            )
          : SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  isBooked = appointment.status!.toLowerCase() == 'booked';
                  isConducted =
                      appointment.status!.toLowerCase() == 'conducted';
                  isCancelled =
                      appointment.status!.toLowerCase() == 'cancelled';
                  return buildAppointmentCard(context, appointment);
                },
              ),
            ),
    );
  }

  Widget buildAppointmentCard(BuildContext context, Appointment appointment) {
    return Stack(
      children: [
        Card(
          color: isBooked
              ? AppColors.primary.withOpacity(0.5)
              : isConducted
                  ? AppColors.success.withOpacity(0.5)
                  : AppColors.danger.withOpacity(0.5),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                  text: 'Appointment ID: ${appointment.appointmentId}',
                  fWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.sp),
                textWidget(
                  text: 'Customer ID: ${appointment.customerId}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.sp),
                textWidget(
                  text: 'Consultant ID: ${appointment.consultantId}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Status: ${appointment.status}',
                      fWeight: FontWeight.normal,
                      color: AppColors.white,
                    ),
                    Icon(
                      isBooked
                          ? Icons.calendar_month
                          : isConducted
                              ? Icons.check_box
                              : Icons.cancel,
                      color: AppColors.white,
                      // color: isBooked
                      //     ? AppColors.primary
                      //     : isConducted
                      //         ? AppColors.success
                      //         : AppColors.danger,
                      size: 20.sp,
                    )
                  ],
                ),
                SizedBox(height: 5.sp),
                textWidget(
                  text: 'Branch ID: ${appointment.branchId}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.sp),
                textWidget(
                  text: 'Business ID: ${appointment.businessId}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
                if (appointment.appointmentNote != null) SizedBox(height: 5.sp),
                if (appointment.appointmentNote != null)
                  textWidget(
                    text: 'Appointment Note: ${appointment.appointmentNote}',
                    fWeight: FontWeight.normal,
                    color: AppColors.white,
                  ),
                SizedBox(height: 5.sp),
                textWidget(
                  text:
                      'Date: ${appointment.appointmentDate!.toPkFormattedDate()}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.sp),
                textWidget(
                  text:
                      'Start: ${appointment.start.toString().split(' ').last.fromStringtoFormattedTime()}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.sp),
                textWidget(
                  text:
                      'End: ${appointment.end.toString().split(' ').last.fromStringtoFormattedTime()}',
                  fWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
        if (isBooked)
          Positioned(
            top: 10.sp,
            right: 10.sp,
            child: PopupMenuButton(
              iconColor: AppColors.white,
              onSelected: (value) {
                if (value == 'update') {
                  CustomDialogue.showUpdateDialog(
                    context,
                    appointment: appointment,
                    onUpdate: widget.onUpdate,
                  );
                } else if (value == 'reSchedule') {
                  CustomDialogue.showRecheduleDialogue(
                    context,
                    appointment,
                    onUpdate: (Map<String, dynamic> selectedValue) {
                      reScheduleAppointment(
                          context,
                          appointment,
                          selectedValue['selectedDate'],
                          selectedValue['selectedTime']);
                    },
                  );
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'update',
                    child: textWidget(text: 'Update'),
                  ),
                  PopupMenuItem(
                    value: 'reSchedule',
                    child: textWidget(text: 'Reschedule'),
                  ),
                ];
              },
            ),
          )
      ],
    );
  }

  static Future<void> reScheduleAppointment(
    BuildContext context,
    Appointment appointment,
    String date,
    String time,
  ) async {
    try {
      Api api = Api(
        dio,
        baseUrl: Constants.baseUrl,
      );
      log('time1 ${time}');
      log('time1 date ${date}');
      dynamic res = await api.reScheduleAppointment({
        "consultant_id": appointment.consultantId,
        "customer_id": appointment.customerId,
        "business_id": appointment.businessId,
        "schedule_time": time,
        "appointment_date": date,
        "id": appointment.appointmentId,
        "branch_id": appointment.branchId,
      });

      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        CustomDialogue.message(context: context, message: res['message']);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        // onUpdate();
      } else {
        if (res.toString().contains('message')) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
        } else {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
    } catch (e) {
      log('Something went wrong in Reschedule Appointment api $e');
      CustomDialogue.message(
          // ignore: use_build_context_synchronously
          context: context,
          message: 'Appointment not Rescheduled $e');
    }
  }
}
