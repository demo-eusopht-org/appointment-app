import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogue {
  static message({required BuildContext context, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: textWidget(text: message),
          ),
        );
      },
    );
  }

  static void displayDialogue(
    BuildContext context, {
    required String message,
    Function? okayTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: textWidget(
            text: message,
            fSize: 13.0,
            fWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: textWidget(
                        text: 'Cancel',
                        fSize: 15.0,
                        fWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        okayTap?.call();
                      },
                      child: textWidget(
                        text: 'OK',
                        fSize: 15.0,
                        fWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showUpdateDialog(
    BuildContext context, {
    required Appointment appointment,
    required Function onUpdate,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        String status = 'cancelled';
        final TextEditingController notesController = TextEditingController();

        return AlertDialog(
          title: textWidget(
            text: 'Update Appointment',
            fSize: 18.0,
            fWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: status,
                decoration: InputDecoration(
                  labelText: 'Status',
                ),
                items: [
                  DropdownMenuItem(
                    value: 'cancelled',
                    child: textWidget(text: 'Cancel'),
                  ),
                  DropdownMenuItem(
                    value: 'conducted',
                    child: textWidget(text: 'Completed'),
                  ),
                ],
                onChanged: (value) {
                  status = value!;
                },
              ),
              SizedBox(height: 10.sp),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Write some Note',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: textWidget(text: 'Cancel', color: Colors.red),
            ),
            TextButton(
              onPressed: () async {
                await updateAppointment(
                  context,
                  appointment.appointmentId.toString(),
                  status,
                  notesController.text,
                  onUpdate,
                );
              },
              child: textWidget(text: 'Update', color: Colors.green),
            ),
          ],
        );
      },
    );
  }

  static Future<void> updateAppointment(
    BuildContext context,
    String appointmentId,
    String status,
    String notes,
    Function onUpdate,
  ) async {
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
        CustomDialogue.message(context: context, message: res['message']);
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
          message: 'Appointment not created $e');
    }
  }
}
