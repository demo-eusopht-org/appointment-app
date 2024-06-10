import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';

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
    log('eventList ${appointment}');
    appointment = widget.appointment;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textWidget(
          text: '${appointment!.status}',
          color: AppColors.black,
        ),
      ],
    );
  }
}
