import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:flutter/cupertino.dart';
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
    } on SocketException catch (e) {
      CustomDialogue.message(
          context: context,
          message:
              'Consultant not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Consultant not found: Please try again');

      print('Consultant not found: Please try again : ${e}');
      return null;
    }
  }

  static Future<GetCustomer?> getCustomer(
    BuildContext context,
    String uri,
    dynamic user,
  ) async {
    try {
      final res = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer ${user['token']}',
      });

      if (res.statusCode == 200) {
        GetCustomer tempConsutlant = GetCustomer.fromJson(jsonDecode(res.body));

        if (tempConsutlant.customers!.isEmpty) {
          return null;
        }

        return tempConsutlant;
      }
      return null;
    } on SocketException catch (e) {
      CustomDialogue.message(
          context: context,
          message: 'Customer not found\nPlease check your internet connection');
      return null;
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Customer not found: Please try again');

      print('Customer not found: Please try again : ${e}');
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
}
