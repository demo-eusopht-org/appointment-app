import 'package:appointment_management/src/resources/assets.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/text_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Settings',
      ),
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.buttonColor,
              height: MediaQuery.sizeOf(context).height * 0.18,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset('assets/images/Vector 1.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset('assets/images/Vector 2.png'),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppImages.men3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildDetails(String text, String label) {
    return Column(
      children: [
        textWidget(
          text: text,
          fSize: 10.0,
          fWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: textWidget(
              text: label,
              fSize: 10.0,
              fWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ],
    );
  }
}
