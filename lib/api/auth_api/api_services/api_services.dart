import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
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
        return GetConsultant.fromJson(jsonDecode(res.body));
      }
      return null;
    } on SocketException catch (e) {
      CustomDialogue.message(
          context: context,
          message:
              'Consultant not found\nPlease check your internet connection');
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Consultant not found: Please try again');

      print('Consultant not found: Please try again : ${e}');
    }
  }
}
