import 'dart:developer';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class MyWhatsAppShare {
  static Future<bool> onShare(
    BuildContext context,
    Appointment appointment,
  ) async {
    final branches = GetLocalData.getBranches();
    final customers = GetLocalData.getCustomers();
    final consultants = GetLocalData.getConsultants();
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
    var customer = customers
        .where(
          (element) =>
              element.id.toString() == appointment.customerId.toString(),
        )
        .first;
    String customerName = customer.name!;
    String customerPhone =
        customer.mobile!; // Assuming phone is a field in customer
    String consultantName = consultants
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

Please arrive ${business.arrivalTime!} early.

For any concerns, contact us at ${business.phoneNumber}.

Best Regards,
${business.name!.toUpperCaseFirst()}''';

      await WhatsappShare.share(
        phone: customerPhone,
        text: appointmentText,
        package: Package.whatsapp, // or Package.businessWhatsapp for business
      );

      return true;
    } catch (e) {
      CustomDialogue.message(context: context, message: e.toString());
      print(e.toString());
      return false;
    }
  }
}
