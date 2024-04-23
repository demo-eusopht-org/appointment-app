import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.65,
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            Row(
              children: [
                Image.asset('assets/images/Male User.png'),
                SizedBox(width: 5),
                textWidget2(
                  text: 'Ali',
                  fSize: 20.0,
                  fWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Settings',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Add Doctor',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Settings',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Add Patient',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Patient Directory',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Add Appoitment',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: textWidget2(
                text: 'Procedures',
                fSize: 16.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Container(
              height: 38,
              child: RoundedElevatedButton(
                borderRadius: 38.0,
                onPressed: () {},
                text: 'Sign Out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
