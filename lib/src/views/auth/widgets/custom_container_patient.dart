import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomInfoContainer extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final double height;
  final double width;

  const CustomInfoContainer({
    Key? key,
    required this.label,
    required this.value,
    this.color = Colors.blue, // Default color
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withOpacity(0.9),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textWidget(
            text: label,
            fSize: 15.0,
            fWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textWidget(
            text: value,
            fSize: 16.0,
            fWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
