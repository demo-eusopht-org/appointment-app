import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class utils {
  static pkFormatDate(String date, String type) {
    DateTime originalDate = DateTime.parse(date);
    if (type == 'onlyDate') {
      return DateFormat('dd-MM-yyyy').format(originalDate);
    } else {
      return '';
    }
  }

  static formatDate(String date, String type) {
    DateTime originalDate = DateTime.parse(date);
    if (type == 'onlyDate') {
      return DateFormat('yyyy-MM-dd').format(originalDate);
    } else {
      return '';
    }
  }

  static DateTime parseIntoDate(String date, String type) {
    if (type == 'onlyDate') {
      return DateFormat('dd-MM-yyyy').parse('${date}');
    } else {
      final date = DateTime.now();
      return DateFormat('dd-MM-yyyy')
          .parse('${date.day}-${date.month}-${date.year}');
    }
  }

  static void launchPhoneApp(BuildContext context, String? phoneNumber) async {
    if (phoneNumber != null) {
      final uri = 'tel:$phoneNumber';

      if (await canLaunchUrl(Uri.parse(uri))) {
        await launchUrl(Uri.parse(uri));
      } else {
        throw 'Could not launch $uri';
      }
    } else {
      CustomDialogue.message(
          context: context, message: 'Phone No. doesn\'t found');
    }
  }

  static Future<TimeOfDay?> selectTime(
    BuildContext context,
  ) async {
    TimeOfDay? pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedDate != null) {
      return pickedDate;
    }
    return null;
  }
}
