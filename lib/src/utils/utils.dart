import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/utils/extensions.dart';
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
    try {
      if (phoneNumber != null) {
        final uri = Uri(scheme: 'tel', path: phoneNumber);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch $uri';
        }
      } else {
        CustomDialogue.message(
            context: context, message: 'Phone No. doesn\'t found');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomDialogue.message(context: context, message: '$e');
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

  static Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return picked;
    }
  }

  static DateTime mergingDateTime(Appointment appointment) {
    final date = appointment.appointmentDate!.toString().split(' ').first;
    final time = appointment.scheduleTime;

    final dateTime = '${date} ${time}';
    return dateTime.toDateTime();
  }

  static DateTime mergeTime(DateTime appointmentDate, String scheduleTime) {
    final date = appointmentDate.toString().split(' ').first;

    final time = scheduleTime;

    final dateTime = '$date $time';
    return dateTime.toDateTime();
  }

  static void setUserRole(User user) {
    if (user.roleId == 1) {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  static Future<void> updatingUser({
    required bool updateProfile,
    required User userData,
    String? name,
    String? field,
    String? about,
  }) async {
    final updatedUser = User(
      userid: userData.userid,
      businessId: userData.businessId,
      name: updateProfile ? name : userData.name,
      about: updateProfile ? about : userData.about,
      field: updateProfile ? field : userData.field,
      email: userData.email,
      createdAt: userData.createdAt,
      updatedAt: userData.updatedAt,
      id: userData.id,
      verified: isAdmin! ? 1 : 2,
      roleId: userData.roleId,
      experience: userData.experience,
      imageName: userData.imageName,
      phoneNumber: userData.phoneNumber,
    );

    final tempUser = locator<LocalStorageService>().getData(key: 'user');

    String token = tempUser['token'];

    AuthResponse user = AuthResponse(token: token, user: updatedUser);

    await locator<LocalStorageService>().delete('user');
    await locator<LocalStorageService>().saveData(
      key: 'user',
      value: user.toJson(),
    );
  }
}
