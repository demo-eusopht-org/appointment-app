import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/views/Assign%20Consultant%20Schedule/assign_consultant_schedule.dart';
import 'package:appointment_management/src/views/Assign%20branch/assign_branch.dart';
import 'package:appointment_management/src/views/Consultant/add_consultant.dart';
import 'package:appointment_management/src/views/Appointments/appointment_booking.dart';
import 'package:appointment_management/src/views/Appointments/appointments.dart';
import 'package:appointment_management/src/views/Auth/login.dart';
import 'package:appointment_management/src/views/Consultant%20Branch/create_branch.dart';
import 'package:appointment_management/src/views/Settings%20page/settings_page.dart';
import 'package:appointment_management/src/views/Verify%20Email/verify_email.dart';
import 'package:appointment_management/src/views/customer/add_customer.dart';
import 'package:appointment_management/src/views/customer/customer_directory.dart';
import 'package:appointment_management/src/views/Services/services_list.dart';
import 'package:appointment_management/src/views/Settings/business_profile_screen.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = locator<LocalStorageService>().getData(key: 'user');

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
                textWidget(
                  text: '${user!['user']['name']}',
                  fSize: 20.0,
                  fWeight: FontWeight.w700,
                ),
              ],
            ),
            if (isAdmin!)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    child: textWidget(
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
                          builder: (context) => AddCustomer(),
                        ),
                      );
                    },
                    child: textWidget(
                      text: 'Add Customer',
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
                          builder: (context) => const CreateBranch(),
                        ),
                      );
                    },
                    child: textWidget(
                      text: 'Create Branch',
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
                          builder: (context) => const AssignBranch(),
                        ),
                      );
                    },
                    child: textWidget(
                      text: 'Assign Branch',
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
                          builder: (context) =>
                              const AssignConsultantSchedule(),
                        ),
                      );
                    },
                    child: textWidget(
                      text: 'Assign Consultant Schedule',
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
                    child: textWidget(
                      text: 'Customer Directory',
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
                    child: textWidget(
                      text: 'Add Appointment',
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
                    child: textWidget(
                      text: 'Services',
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
                          builder: (context) => const BusinessProfileScreen(),
                        ),
                      );
                    },
                    child: textWidget(
                      text: 'Business Profile',
                      fSize: 14.0,
                      fWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Appointments(),
                  ),
                );
              },
              child: textWidget(
                text: 'Appointments',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const VerifyEmail(),
                  ),
                );
              },
              child: textWidget(
                text: 'Verify Email',
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
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: textWidget(
                text: 'Settings page',
                fSize: 14.0,
                fWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Container(
              height: 38,
              child: RoundedElevatedButton(
                borderRadius: 38.0,
                onPressed: () async {
                  isAdmin = null;
                  await locator<LocalStorageService>().clearAll();
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
