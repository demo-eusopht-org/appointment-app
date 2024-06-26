import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentCountWidget extends StatelessWidget {
  const AppointmentCountWidget({
    super.key,
    required this.title,
    required this.totalappointments,
  });
  final String title;
  final String totalappointments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
        margin: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(
              textAlign: TextAlign.center,
              text: title,
              color: AppColors.white,
              fSize: 10.sp,
              fWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 5,
            ),
            textWidget(
              textAlign: TextAlign.center,
              text: totalappointments,
              color: AppColors.white,
              fSize: 18.0,
              fWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
