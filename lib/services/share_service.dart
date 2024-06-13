import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

class MySharePlus {
  static Future<bool> onShare(
    BuildContext context,
    Appointment appointment,
  ) async {
    final branches = GetLocalData.getBranches();
    final customer = GetLocalData.getCustomers();
    final consultant = GetLocalData.getConsultants();
    final businessData = GetLocalData.getBusiness();

    String appointmentData = appointment.appointmentDate!.toPkFormattedDate();
    String startTime = appointment.start
        .toString()
        .split(' ')
        .last
        .fromStringtoFormattedTime();
    String endTime =
        appointment.end.toString().split(' ').last.fromStringtoFormattedTime();

    String branch = branches
        .where(
          (element) => element.id.toString() == appointment.branchId,
        )
        .first
        .address!;
    String customerName = customer
        .where(
          (element) =>
              element.id.toString() == appointment.customerId.toString(),
        )
        .first
        .name!;
    String consultantName = consultant
        .where(
          (element) =>
              element.id.toString() == appointment.consultantId.toString(),
        )
        .first
        .name!;
    Business business = businessData
        .where(
          (element) =>
              element.id.toString() == appointment.businessId.toString(),
        )
        .first;

    try {
      await Share.share(
        '''
Hello ${customerName.toUpperCaseFirst()},

We are pleased to inform you that you have an upcoming appointment scheduled on $appointmentData between $startTime to $endTime with Consultant ${consultantName.toUpperCaseFirst()}. The appointment will take place at $branch. Please make sure to arrive at least 10 minutes before the scheduled time to complete any necessary preparations.

If you have any questions or need to reschedule, please feel free to contact us at ${business.phoneNumber}. We look forward to seeing you soon and appreciate your punctuality.

Best regards,

${business.name!.toUpperCaseFirst()}
  ''',
        subject: "Appoitment Schedule",
      );

      return true;
    } catch (e) {
      CustomDialogue.message(context: context, message: '${e.toString()}');
      print(e.toString());
      return false;
    }
  }
}
