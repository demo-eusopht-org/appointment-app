import 'dart:developer';

import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerHistory extends StatefulWidget {
  final List<Appointment> customerAppointments;
  const CustomerHistory({
    super.key,
    required this.customerAppointments,
  });

  @override
  State<CustomerHistory> createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
  List<Appointment> customerAppointments = [];

  int? totalSchedule, totalVisited, totalCancelled;

  List<Consultant> consultants = [];
  @override
  void initState() {
    super.initState();
    consultants = GetLocalData.getConsultants();
    customerAppointments = widget.customerAppointments;
    totalSchedule = customerAppointments
        .where((element) => element.status!.toLowerCase() == 'booked')
        .toList()
        .length;
    totalVisited = customerAppointments
        .where((element) => element.status!.toLowerCase() == 'conducted')
        .toList()
        .length;
    totalCancelled = customerAppointments
        .where((element) => element.status!.toLowerCase() == 'cancelled')
        .toList()
        .length;
  }

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
        title: 'Customer History',
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            AppImages.vectorPatient,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.all(18),
            //   color: AppColors.primary,
            //   height: MediaQuery.sizeOf(context).height * 0.18,
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         top: 0,
            //         left: 0,
            //         child: Image.asset('assets/images/Vector 1.png'),
            //       ),
            //       Positioned(
            //         bottom: 0,
            //         right: 0,
            //         child: Image.asset('assets/images/Vector 2.png'),
            //       ),
            //       Positioned(
            //         top: 0,
            //         left: 10,
            //         bottom: 0,
            //         right: 0,
            //         child: Row(
            //           children: [
            //             Image.asset(
            //               AppImages.patient,
            //               height: 75,
            //             ),
            //             Expanded(
            //               child: GridView(
            //                 padding: EdgeInsets.only(top: 10, left: 8),
            //                 shrinkWrap: true,
            //                 gridDelegate:
            //                     SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 3,
            //                   childAspectRatio: 1.6,
            //                 ),
            //                 physics: NeverScrollableScrollPhysics(),
            //                 children: [
            //                   _buildDetails(
            //                       'Customer Name', customer?.name ?? '--'),
            //                   _buildDetails(
            //                       'Height', '${customer?.height ?? '--'}'),
            //                   _buildDetails('Age', '${customer?.age ?? '--'}'),
            //                   _buildDetails(
            //                       'Email Address', customer?.email ?? '--'),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.sp,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  totalCountWidget(
                    title: 'Total Visited',
                    totalCount: totalVisited!,
                    color: AppColors.success,
                  ),
                  totalCountWidget(
                    title: 'Total Schedule',
                    totalCount: totalSchedule!,
                    color: AppColors.primary,
                  ),
                  totalCountWidget(
                    title: 'Total Cancelled',
                    totalCount: totalCancelled!,
                    color: AppColors.danger,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              // width: 360,
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: textWidget(
                          text: 'Consultant',
                          fWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: textWidget(
                          text: 'Date',
                          fWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: textWidget(
                          text: 'Time',
                          fWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            if (customerAppointments.isEmpty)
              textWidget(text: 'No Customer history found'),
            Expanded(
              child: ListView.builder(
                  itemCount: customerAppointments.length,
                  itemBuilder: (context, index) {
                    Appointment appointment = customerAppointments[index];

                    Consultant tempConsultant = consultants
                        .where(
                            (element) => element.id == appointment.consultantId)
                        .first;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: textWidget(
                                    text:
                                        tempConsultant.name!.toUpperCaseFirst(),
                                    fSize: 12.0.sp,
                                    maxline: 1,
                                    textOverFlow: TextOverflow.ellipsis,
                                    fWeight: FontWeight.w600,
                                    color: appointment.status == 'booked'
                                        ? AppColors.primary
                                        : appointment.status == 'completed'
                                            ? AppColors.success
                                            : AppColors.danger,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: textWidget(
                                    text: appointment.appointmentDate!
                                        .toPkFormattedDate(),
                                    fSize: 12.sp,
                                    fWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: textWidget(
                                    text: appointment.scheduleTime!
                                        .fromStringtoFormattedTime(),
                                    fSize: 12.sp,
                                    fWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     alignment: Alignment.center,
                              //     height: 30,
                              //     width: 89,
                              //     child: ElevatedButton(
                              //       onPressed: () {
                              //         Navigator.push(
                              //           context,
                              //           CupertinoPageRoute(
                              //             builder: (context) => ViewDetails(),
                              //           ),
                              //         );
                              //       },
                              //       child: textWidget(
                              //         text: 'View Details',
                              //         fSize: 6.0,
                              //         fWeight: FontWeight.w800,
                              //         color: Colors.white,
                              //       ),
                              //       style: ElevatedButton.styleFrom(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(47),
                              //         ),
                              //         backgroundColor: AppColors.primary,
                              //         foregroundColor: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(),
                      ],
                    );
                  }),
            )
          ],
        ),
      ]),
    );
  }

  Expanded totalCountWidget({
    required String title,
    required int totalCount,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(
                text: totalCount.toString(),
                fWeight: FontWeight.w600,
                fSize: 16.sp,
                color: Colors.white,
              ),
              textWidget(
                text: title,
                fWeight: FontWeight.w600,
                fSize: 10.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(String text, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textWidget(
          text: text,
          fWeight: FontWeight.w600,
          color: Colors.white,
        ),
        Expanded(
          child: textWidget(
            text: label,
            fWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
