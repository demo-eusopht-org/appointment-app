import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDialogue extends StatelessWidget {
  final String message;

  const ConfirmationDialogue({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.sp),
        topRight: Radius.circular(15.sp),
      ),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom divider
            Container(
              width: MediaQuery.sizeOf(context).width * 0.09,
              margin: EdgeInsets.only(
                bottom: 10.sp,
              ),
              height: 4.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            Text(
              message,
              style: MyTextStyles.smallBlacktext.copyWith(
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.sp,
                        horizontal: 20.sp,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(10.sp),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.danger.withOpacity(0.5),
                            spreadRadius: 2.sp,
                            blurRadius: 5.sp,
                            offset: Offset(0, 3.sp),
                          ),
                        ],
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.sp),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.sp,
                        horizontal: 20.sp,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(10.sp),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.5),
                            spreadRadius: 2.sp,
                            blurRadius: 5.sp,
                            offset: Offset(0, 3.sp),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
