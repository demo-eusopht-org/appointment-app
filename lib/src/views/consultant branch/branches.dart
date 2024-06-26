import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Consultant%20Branch/create_branch.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchesPage extends StatefulWidget {
  final List<Appointment>? appointments;

  const BranchesPage({super.key, this.appointments});

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  List<Appointment> appointments = [];

  List<Branch> branches = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    branches = GetLocalData.getBranches();
    branches.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Branches',
          leadingIcon: const Icon(
            Icons.arrow_back_outlined,
          ),
          leadingIconOnTap: () {
            Navigator.pop(context);
          },
          action: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CreateBranch(),
                  ),
                ).then((value) {
                  log('value ${value}');
                  if (value) {
                    setState(() {});
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Icon(
                  Icons.add,
                  size: 22.sp,
                ),
              ),
            )
          ]),
      body: branches.isEmpty
          ? Center(
              child: Text(
                'No Branches Found',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                return buildAppointmentCard(context, branch);
              },
            ),
    );
  }

  Widget buildAppointmentCard(BuildContext context, Branch branch) {
    return Card(
      color: AppColors.primary,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
              text: branch.address!,
              fSize: 15.sp,
              color: AppColors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: 'Start',
                        fSize: 15.sp,
                        color: AppColors.white,
                      ),
                      textWidget(
                        text: branch.startTime!.fromHourMintoFormattedTime(),
                        fSize: 15.sp,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: 'End',
                        fSize: 15.sp,
                        color: AppColors.white,
                      ),
                      textWidget(
                        text: branch.endTime!.fromHourMintoFormattedTime(),
                        fSize: 15.sp,
                        color: AppColors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(
                  text: 'CreatedAt',
                  fSize: 15.sp,
                  color: AppColors.white,
                ),
                textWidget(
                  text: branch.createdAt!.toFormattedDate(),
                  fSize: 15.sp,
                  color: AppColors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
