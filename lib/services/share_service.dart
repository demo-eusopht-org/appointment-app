import 'dart:developer';

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

    Business business = businessData.where(
      (element) {
        log('tempBusiness ${element.id}');
        log('tempBusiness ${appointment.businessId}');
        return element.id == appointment.businessId;
      },
    ).first;

    try {
      String appointmentText = '''Hi ${customerName.toUpperCaseFirst()},

Your appointment with consultant ${consultantName.toUpperCaseFirst()} is scheduled as follows:

Date: $appointmentData
Time: $startTime to $endTime
Address: $branch

Please arrive 10 minutes early.

For any concerns, contact us at ${business.phoneNumber}.

Best Regards,
${business.name!.toUpperCaseFirst()}''';

      await Share.share(
        appointmentText,
        subject: "Appoitment Schedule",
      );

      return true;
    } catch (e) {
      CustomDialogue.message(context: context, message: e.toString());
      print(e.toString());
      return false;
    }
  }
}
