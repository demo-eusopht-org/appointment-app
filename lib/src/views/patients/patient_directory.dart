import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';
import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/custom_drawer.dart';

class PatientDirectory extends StatefulWidget {
  const PatientDirectory({super.key});

  @override
  State<PatientDirectory> createState() => _PatientDirectoryState();
}

class _PatientDirectoryState extends State<PatientDirectory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: customAppBar(
          context: context,
          title: 'Patient Directory',
          leadingIcon: Image.asset(
            AppImages.menuIcon,
          ),
          leadingIconOnTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          action: [
            Image.asset(
              AppImages.notification,
              width: 50,
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Divider(
                          color: Colors.grey.shade300,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              child: Image.asset(
                                AppImages.men2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            textWidget(
                              text: 'Abid',
                              fSize: 18.0,
                              fWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.buttonColor,
                              radius: 22,
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.buttonColor,
                              radius: 22,
                              child: Icon(
                                Icons.mail,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
