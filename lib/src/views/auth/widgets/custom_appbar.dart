import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({
  required BuildContext context,
  controller,
  title,
  action,
  VoidCallback? leadingIconOnTap, // Add this parameter for onTap functionality
  Widget? leadingIcon, // Add this parameter for leading icon widget
}) {
  return AppBar(
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: leadingIconOnTap,
        child: leadingIcon,
      ),
    ),
    title: textWidget(
      text: title ?? '',
      color: Colors.black,
      fSize: 17.0,
      fWeight: FontWeight.w800,
    ),

    centerTitle: true,
    backgroundColor:
        Colors.transparent, // Make the app bar background transparent
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.onBoardingGradient,
        ),
      ),
    ),
    actions: action,
  );
}
