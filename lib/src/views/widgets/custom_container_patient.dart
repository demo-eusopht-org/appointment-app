import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
      // height: height,
      // width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withOpacity(0.9),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textWidget(
            text: '$label: ',
            color: AppColors.white,
            fWeight: FontWeight.w600,
          ),
          textWidget(
            text: value,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
