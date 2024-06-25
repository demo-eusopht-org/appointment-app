import 'dart:developer';

import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/Auth/widgets/change_password.dart';
import 'package:appointment_management/src/views/Settings/privacy_policy.dart';
import 'package:appointment_management/src/views/Settings/update_arrival_time.dart';
import 'package:appointment_management/src/views/Verify%20Email/verify_email.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Settings',
      ),
      body: Column(
        children: [
          SizedBox(height: 10.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Card(
              color: AppColors.primary,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const VerifyEmail(),
                    ),
                  );
                },
                title: textWidget(
                  text: 'Verify Email',
                  color: AppColors.white,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Card(
              color: AppColors.primary,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ),
                  );
                },
                title: textWidget(
                  text: 'Privacy Policy',
                  color: AppColors.white,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Card(
              color: AppColors.primary,
              child: ListTile(
                onTap: () {
                  final route = CupertinoPageRoute(
                    builder: (context) =>
                        const ChangePassword(fromSettingPage: true),
                  );
                  Navigator.push(context, route);
                },
                title: textWidget(
                  text: 'Change Password',
                  color: AppColors.white,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Card(
              color: AppColors.primary,
              child: ListTile(
                onTap: () {
                  final route = CupertinoPageRoute(
                    builder: (context) => const UpdateArrivalTimePage(),
                  );
                  Navigator.push(context, route);
                },
                title: textWidget(
                  text: 'Update Arrival time',
                  color: AppColors.white,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
