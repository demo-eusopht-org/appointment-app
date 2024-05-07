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
}
