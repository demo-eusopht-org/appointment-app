import 'package:appointment_management/src/views/Consultant/add_consultant.dart';
import 'package:appointment_management/src/views/appointments/appointment_booking.dart';
import 'package:appointment_management/src/views/appointments/appointments.dart';
import 'package:appointment_management/src/views/auth/login.dart';
import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:appointment_management/src/views/patients/add_patients.dart';
import 'package:appointment_management/src/views/patients/patient_directory.dart';
import 'package:appointment_management/src/views/procedure/procedure_list.dart';
import 'package:appointment_management/src/views/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
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
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Settings',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AddConsultant(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Add Consultant',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AddPatients(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Add Patient',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PatientDirectory(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Patient Directory',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AppointmentBooking(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Add Appoitment',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ProcedureList(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Procedures',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Appointments(),
                  ),
                );
              },
              child: textWidget2(
                text: 'Appointments',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Container(
              height: 38,
              child: RoundedElevatedButton(
                borderRadius: 38.0,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (_) => false,
                  );
                },
                text: 'Sign Out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
