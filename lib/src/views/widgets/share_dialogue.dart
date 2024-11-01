import 'package:flutter/material.dart';

class ShareOptionsDialog extends StatelessWidget {
  final String title;
  final String content;
  final String textToShare;
  final String phoneNumber;
  final VoidCallback onWhatsAppShare;
  final VoidCallback onSmsShare;
  final VoidCallback onNativeShare;

  const ShareOptionsDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.textToShare,
    required this.phoneNumber,
    required this.onWhatsAppShare,
    required this.onSmsShare,
    required this.onNativeShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      content: Text(content),
      actions: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextButton(context, 'WhatsApp', onWhatsAppShare),
              SizedBox(width: 10),
              _buildTextButton(context, 'SMS', onSmsShare),
              SizedBox(width: 10),
              _buildTextButton(context, 'Share', onNativeShare),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // Close the dialog
        onPressed(); // Trigger respective share action
      },
      child: Text(label),
    );
  }
}
