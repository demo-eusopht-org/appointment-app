import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';
import '../auth/widgets/custom_button.dart';
import '../auth/widgets/text_widget.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap the column with a Center widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    size: 40,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  textWidget(
                    text: 'Thank You!',
                    fSize: 23.0,
                    fWeight: FontWeight.w700,
                    color: AppColors.buttonColor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  textWidget2(
                    text: 'Your Appointment Created',
                    fWeight: FontWeight.w700,
                    fSize: 19.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                textWidget2(
                  text: "Share On WhatsApp",
                  fSize: 15.0,
                  fWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: 5,
                ),
                Image.asset(AppImages.whatsapp)
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width * 0.8,
              child: RoundedElevatedButton(
                borderRadius: 6,
                onPressed: () {},
                text: "Done",
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
