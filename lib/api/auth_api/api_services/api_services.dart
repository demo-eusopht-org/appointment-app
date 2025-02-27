import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_branches.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_schedule.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<GetConsultant?> getConsultant(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetConsultant tempConsutlant =
            GetConsultant.fromJson(jsonDecode(res.body));

        if (tempConsutlant.consultants.isEmpty) {
          return null;
        }
        return tempConsutlant;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Consultant not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      // CustomDialogue.message(
      //     context: context, message: 'Consultant not found: Please try again');

      log('Consultant not found: Please try again : ${e}', stackTrace: stack);
      return null;
    }
  }

  static Future<GetCustomer?> getCustomer(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      log('uri ${uri}');
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        final resBody = jsonDecode(res.body);

        GetCustomer tempCustomer = GetCustomer.fromJson(resBody);
        if (tempCustomer.customers!.isEmpty) {
          return null;
        }

        return tempCustomer;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message: 'Customer not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      // CustomDialogue.message(
      //     context: context, message: 'Customer not found: Please try again');

      log('Customer not found: Please try again : ${e}', stackTrace: stack);
      return null;
    }
  }

  static Future<GetServices?> getServices(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetServices tempServices = GetServices.fromJson(jsonDecode(res.body));

        if (tempServices.services!.isEmpty) {
          return null;
        }

        return tempServices;
      }
      return null;
    } on SocketException catch (e) {
      CustomDialogue.message(
          context: context,
          message: 'Services not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Services not found: Please try again');

      print('Services not found: Please try again : ${e}');
      return null;
    }
  }

  static Future<GetBranch?> getBusinessBranch(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetBranch tempBranch = GetBranch.fromJson(jsonDecode(res.body));

        if (tempBranch.businessBranches!.isEmpty) {
          return null;
        }
        return tempBranch;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Business branch not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      // CustomDialogue.message(
      //     context: context,
      //     message: 'Business branch not found: Please try again');

      print('Business branch not found: Please try again : ${e}');
      return null;
    }
  }

  static Future<GetConsultantBranches?> getConsultantBranches(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetConsultantBranches tempConsultantBranches =
            GetConsultantBranches.fromJson(jsonDecode(res.body));

        if (tempConsultantBranches.consultant!.isEmpty) {
          return null;
        }

        return tempConsultantBranches;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Consultant Branches not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      CustomDialogue.message(
          context: context,
          message: 'Consultant Branches not found: Please try again');

      log('Consultant Branches not found: Please try again : ${e}',
          stackTrace: stack);
      return null;
    }
  }

  static Future<GetConsultantSchedule?> getConsultantSchedule(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetConsultantSchedule tempConsultantBranches =
            GetConsultantSchedule.fromJson(jsonDecode(res.body));

        if (tempConsultantBranches.consultantSchedule!.isEmpty) {
          return null;
        }

        return tempConsultantBranches;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Consultant Schedule not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      CustomDialogue.message(
          context: context,
          message: 'Consultant Schedule not found: Please try again');

      log('Consultant Schedule not found: Please try again : ${e}',
          stackTrace: stack);
      return null;
    }
  }

  static Future<GetAllAppointments?> getAllAppointments(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        log('res.body ${res.body}');
        GetAllAppointments tempConsultantBranches =
            GetAllAppointments.fromJson(jsonDecode(res.body));

        if (tempConsultantBranches.appointments!.isEmpty) {
          return null;
        }

        return tempConsultantBranches;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Appointment not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      log('Appointment not found: Please try again : ${e}', stackTrace: stack);
      return null;
    }
  }

  static Future<GetBusinessData?> getBusinessData(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetBusinessData tempBranch =
            GetBusinessData.fromJson(jsonDecode(res.body));

        if (tempBranch.business!.isEmpty) {
          return null;
        }
        return tempBranch;
      }
      return null;
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Business data found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      // CustomDialogue.message(
      //     context: context,
      //     message: 'Business data found: Please try again');

      print('Business data found: Please try again : ${e}');
      return null;
    }
  }

  static Future<void> reSaveConsultant(BuildContext context) async {
    final user = locator<LocalStorageService>().getData(key: 'user');
    final businessId =
        locator<LocalStorageService>().getData(key: 'businessId');
    GetConsultant? tempConsultant = await ApiServices.getConsultant(
      context,
      Constants.getBusiness + businessId.toString(),
      user,
    );

    if (tempConsultant != null) {
      await locator<LocalStorageService>().delete('consultants');
      await locator<LocalStorageService>().saveData(
        key: 'consultants',
        value: tempConsultant.consultants.map((e) => e.toJson()).toList(),
      );
      log('waiting here done');
    }
  }

  static Future<void> reSaveCustomer(BuildContext context) async {
    final user = locator<LocalStorageService>().getData(key: 'user');
    final businessId =
        locator<LocalStorageService>().getData(key: 'businessId');
    GetCustomer? tempCustomer = await ApiServices.getCustomer(
      context,
      Constants.getCustomers + businessId.toString(),
      user,
    );

    if (tempCustomer != null) {
      await locator<LocalStorageService>().delete('customers');
      await locator<LocalStorageService>().saveData(
        key: 'customers',
        value: tempCustomer.customers!
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      );
    }
  }

  static Future<void> updateAppointment(
    BuildContext context,
    String appointmentId,
    String status,
    String notes, [
    Function? onUpdate,
  ]) async {
    try {
      Api api = Api(
        dio,
        baseUrl: Constants.baseUrl,
      );

      dynamic res = await api.updateAppointment(
        {
          "id": appointmentId,
          "status": status,
          "notes": notes,
        },
      );

      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        CustomDialogue.message(context: context, message: res['message']);
        // ignore: use_build_context_synchronously
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
      log('Something went wrong in update Appointment api $e');
      CustomDialogue.message(
          // ignore: use_build_context_synchronously
          context: context,
          message: 'Appointment not updated $e');
    }
  }

  
}
