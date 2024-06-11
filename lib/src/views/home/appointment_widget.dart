import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentWidget extends StatefulWidget {
  final Appointment? appointment;
  const AppointmentWidget({super.key, this.appointment});

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  Appointment? appointment;
  @override
  void initState() {
    appointment = widget.appointment;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = appointment!.status!.toLowerCase();
    return Container(
      color: status == 'booked'
          ? AppColors.primary
          : status == 'conducted'
              ? AppColors.success
              : AppColors.danger,
      child: textWidget(
        text: appointment!.scheduleTime!.fromStringtoFormattedTime(),
        color: AppColors.white,
        fSize: 10.sp,
      ),
    );
  }
}
