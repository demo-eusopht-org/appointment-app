import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BusinessItem extends StatelessWidget {
  final String name;
  final String? type;
  final String imagePath;

  const BusinessItem({
    required this.name,
    this.type,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary,
            child: Image.asset(
              imagePath,
              width: 24, // Adjust the width to fit the circle avatar
              height: 24, // Adjust the height to fit the circle avatar
              color: Colors.white, // Optional: Apply color to the image
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget(
                text: name,
                fSize: 14.0,
                fWeight: FontWeight.w700,
              ),
            ],
          )
        ],
      ),
    );
  }
}
