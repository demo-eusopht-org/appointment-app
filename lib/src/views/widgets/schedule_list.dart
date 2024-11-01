import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Appointments/appointment_booking.dart';
import 'package:appointment_management/src/views/Appointments/appointment_details.dart';
import 'package:appointment_management/src/views/widgets/confirmation_dialogue.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ScheduleList extends StatefulWidget {
  List<Appointment> allAppointments;
  ScheduleList({super.key, required this.allAppointments});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  List<Customer>? customer;
  List<Consultant>? consultants;
  List<Branch>? branches;

  @override
  void initState() {
    consultants = GetLocalData.getConsultants();
    customer = GetLocalData.getCustomers();
    branches = GetLocalData.getBranches();
    super.initState();
  }

  bool get isBooked => widget.allAppointments
      .any((element) => element.status!.toLowerCase() == 'booked');
  bool get isConducted => widget.allAppointments
      .any((element) => element.status!.toLowerCase() == 'conducted');
  bool get isCancelled => widget.allAppointments
      .any((element) => element.status!.toLowerCase() == 'cancelled');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.allAppointments.length,
        itemBuilder: (context, index) {
          Appointment appointment = widget.allAppointments[index];
          Customer currentCustomer = getCurrentCustomer(appointment);

          Consultant currentConsultant = getCurrentConsultant(appointment);
          Branch branch = getCurrentBranch(appointment);
          return Column(
            children: [
              InkWell(
                onTap: () {
                  final route = MaterialPageRoute(
                    builder: (context) => AppointmentDetails(
                        appointments: [appointment], onUpdate: () async {}),
                  );
                  Navigator.push(context, route);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.sp),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.sp,
                                backgroundImage: currentCustomer.imageName !=
                                        null
                                    ? CachedNetworkImageProvider(
                                        '${Constants.customerImageBaseUrl}${currentCustomer.imageName}')
                                    : AssetImage(AppImages.noImage)
                                        as ImageProvider<Object>,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  radius: 18,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textWidget(
                                        text: appointment.appointmentDate!
                                            .toMonthNameFormat()
                                            .getMonth(),
                                        fSize: 6.sp,
                                        color: Colors.white,
                                        fWeight: FontWeight.w800,
                                      ),
                                      textWidget(
                                        text: appointment.appointmentDate!
                                            .toMonthNameFormat()
                                            .getDay(),
                                        fSize: 7.sp,
                                        fWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp,
                                        ),
                                        child: textWidget(
                                          text: currentCustomer.name!
                                              .toUpperCaseFirst(),
                                          fSize: 12.sp,
                                          fWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp,
                                        ),
                                        child: textWidget(
                                          text: 'Consultant:',
                                          fSize: 10.sp,
                                          fWeight: FontWeight.w600,
                                          textOverFlow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp,
                                        ),
                                        child: textWidget(
                                          text: currentConsultant.name!
                                              .toUpperCaseFirst(),
                                          fSize: 12.sp,
                                          fWeight: FontWeight.w600,
                                          textOverFlow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isBooked)
                            Row(
                              children: [
                                customeButton(
                                    title: 'Reschedule',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              AppointmentBooking(
                                            reSchedule: true,
                                            appointment: appointment,
                                            customer: currentCustomer,
                                            consultant: currentConsultant,
                                            branch: branch,
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                customeButton(
                                    title: 'Cancel',
                                    onTap: () async {
                                      final result = await showModalBottomSheet(
                                        enableDrag: true,
                                        context: context,
                                        builder: (context) {
                                          return const ConfirmationDialogue(
                                            message:
                                                'Are you sure you want to cancel your appointment?',
                                          );
                                        },
                                      );

                                      if (result ?? false) {
                                        await ApiServices.updateAppointment(
                                          context,
                                          appointment.appointmentId.toString(),
                                          'cancelled',
                                          '',
                                        );
                                      }
                                    }),
                              ],
                            ),
                          if (isConducted)
                            Row(
                              children: [
                                textWidget(
                                  text: 'Completed',
                                  fSize: 12.sp,
                                  color: Colors.green,
                                  fWeight: FontWeight.w800,
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          if (isCancelled)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textWidget(
                                    text: 'Cancelled',
                                    fSize: 12.sp,
                                    color: Colors.red,
                                    fWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.primary,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            textWidget(
                              text: appointment.scheduleTime!
                                  .fromStringtoFormattedTime(),
                              fSize: 8.sp,
                              fWeight: FontWeight.w800,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }

  GestureDetector customeButton(
      {required String title, required Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 7.sp,
          horizontal: 7.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: title == 'Reschedule' ? AppColors.primary : AppColors.danger,
        ),
        child: textWidget(
          text: title,
          fSize: 10.sp,
          fWeight: FontWeight.w800,
          color: AppColors.white,
        ),
      ),
    );
  }

  Customer getCurrentCustomer(Appointment appointment) {
    return customer!
        .where((element) => element.id == appointment.customerId)
        .first;
  }

  Consultant getCurrentConsultant(Appointment appointment) {
    return consultants!
        .where((element) => element.id == appointment.consultantId)
        .first;
  }

  Branch getCurrentBranch(Appointment appointment) {
    return branches!
        .where((element) => element.id.toString() == appointment.branchId)
        .first;
  }
}
