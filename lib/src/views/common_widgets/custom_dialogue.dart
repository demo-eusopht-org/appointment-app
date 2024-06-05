import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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

  static void displayDialogye(
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
                        backgroundColor: AppColors.buttonColor,
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
                        backgroundColor: AppColors.buttonColor,
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
}
