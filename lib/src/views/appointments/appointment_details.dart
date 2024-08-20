import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Appointments/appointment_booking.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetails extends StatefulWidget {
  final List<Appointment>? appointments;
  final Function onUpdate;
  const AppointmentDetails({
    super.key,
    this.appointments,
    required this.onUpdate,
  });

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  List<Appointment> appointments = [];
  @override
  void initState() {
    if (widget.appointments != null) {
      appointments = widget.appointments!;
    }

    super.initState();
  }

  bool isBooked = false;
  bool isConducted = false;
  bool isCancelled = false;

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
        title: 'Appointments Details',
      ),
      body: appointments.isEmpty
          ? Center(
              child: textWidget(
                text: 'No appointments found for this date',
                fWeight: FontWeight.w600,
              ),
            )
          : SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  isBooked = appointment.status!.toLowerCase() == 'booked';
                  isConducted =
                      appointment.status!.toLowerCase() == 'conducted';
                  isCancelled =
                      appointment.status!.toLowerCase() == 'cancelled';
                  return buildAppointmentCard(context, appointment);
                },
              ),
            ),
    );
  }

  Widget buildAppointmentCard(BuildContext context, Appointment appointment) {
    final usersData = getUsersData(appointment);

    Customer? customer = usersData['customer'];
    Consultant? consultant = usersData['consultant'];
    Branch? branch = usersData['branch'];
    Business? business = usersData['business'];
    void _shareViaWhatsApp(String appointmentText, String phoneNumber) async {
      String encodedText = Uri.encodeComponent(appointmentText);
      String url = "https://wa.me/$phoneNumber?text=$encodedText";

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could not launch $url";
      }
    }

    void _shareViaSms(String appointmentText, String phoneNumber) async {
      String encodedText = Uri.encodeComponent(appointmentText);
      String smsUrl = "sms:$phoneNumber?body=$encodedText";

      if (await canLaunch(smsUrl)) {
        await launch(smsUrl);
      } else {
        throw "Could not launch $smsUrl";
      }
    }

    void _shareViaNative(String appointmentText) {
      Share.share(appointmentText);
    }

    void showShareOptionsDialog(
        BuildContext context, String appointmentText, String phoneNumber) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: textWidget(
                text: 'Share Appointment',
                fSize: 20.0,
                fWeight: FontWeight.w600),
            content: textWidget(
                text: 'Choose how you want to share the appointment details.'),
            actions: [
              customTextButton(
                text: 'WhatsApp',
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  _shareViaWhatsApp(appointmentText, phoneNumber);
                },
              ),
              customTextButton(
                text: "SMS",
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  _shareViaSms(appointmentText, phoneNumber);
                },
              ),
              customTextButton(
                text: "Share",
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  _shareViaNative(appointmentText);
                },
              ),
            ],
          );
        },
      );
    }

    return Stack(
      children: [
        Card(
          color: AppColors.primary,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (consultant != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20.sp,
                                backgroundImage: consultant.imageName != null
                                    ? CachedNetworkImageProvider(
                                        '${Constants.consultantImageBaseUrl}${consultant.imageName}',
                                      )
                                    : AssetImage(AppImages.noImage)
                                        as ImageProvider<Object>,
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget(
                                    text: consultant.name!.toUpperCaseFirst(),
                                    fWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                  textWidget(
                                    text: '${consultant.email}',
                                    isUpperCase: false,
                                    fWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          textWidget(
                            text: '${appointment.status}',
                            isUpperCase: false,
                            fWeight: FontWeight.w500,
                            color: isBooked
                                ? AppColors.white
                                : isCancelled
                                    ? AppColors.danger
                                    : AppColors.success,
                          ),
                        ],
                      ),
                    SizedBox(height: 5.sp),
                    if (customer != null)
                      textWidget(
                        text:
                            'Customer Name: ${customer.name!.toUpperCaseFirst()}',
                        fWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    SizedBox(height: 5.sp),
                    if (branch != null)
                      textWidget(
                        text: 'Address: ${branch.address!.toUpperCaseFirst()}',
                        fWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    // SizedBox(height: 5.sp),
                    // if (business != null)
                    //   textWidget(
                    //     text: 'Business Name: ${business.name!.toUpperCaseFirst()}',
                    //     fWeight: FontWeight.w500,
                    //     color: AppColors.white,
                    //   ),
                    if (appointment.appointmentNote != null)
                      SizedBox(height: 5.sp),
                    if (appointment.appointmentNote != null)
                      textWidget(
                        text:
                            'Appointment Note: ${appointment.appointmentNote}',
                        fWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    SizedBox(height: 5.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                          text:
                              'Date: ${appointment.appointmentDate!.toPkFormattedDate()}',
                          fWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                        textWidget(
                          text:
                              'Time: ${appointment.start.toString().split(' ').last.fromStringtoFormattedTime()}',
                          fWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   height: 5.sp,
                    // ),
                    // textWidget(
                    //   text:
                    //       'End: ${appointment.end.toString().split(' ').last.fromStringtoFormattedTime()}',
                    //   fWeight: FontWeight.w500,
                    //   color: AppColors.white,
                    // ),
                    if (isBooked)
                      Column(
                        children: [
                          const Divider(
                            color: AppColors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButtons(
                                title: 'Update',
                                icon: Icons.update,
                                onTap: () {
                                  CustomDialogue.showUpdateDialog(
                                    context,
                                    appointment: appointment,
                                    onUpdate: widget.onUpdate,
                                  );
                                },
                              ),
                              CustomButtons(
                                title: 'Reschedule',
                                icon: Icons.calendar_month,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => AppointmentBooking(
                                        reSchedule: true,
                                        appointment: appointment,
                                        customer: customer,
                                        consultant: consultant,
                                        branch: branch,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              CustomButtons(
                                title: 'Share',
                                icon: Icons.share,
                                onTap: () {
                                  String appointmentText =
                                      '''Hi ${customer!.name!.toUpperCaseFirst()},

Your appointment with consultant ${consultant!.name!.toUpperCaseFirst()} is scheduled as follows:

Date: ${appointment.appointmentDate?.toPkFormattedDate()}
Time: ${appointment.start.toString().split(" ").last.fromStringtoFormattedTime()} to ${appointment.end.toString().split(" ").last.fromStringtoFormattedTime()}
Address: ${branch?.address ?? ''}

Please arrive ${business!.arrivalTime!} early.

For any concerns, contact us at ${business.phoneNumber}.

Best Regards,
${business.name!.toUpperCaseFirst()}''';

                                  showShareOptionsDialog(context,
                                      appointmentText, customer!.mobile!);
                                },
                              )
                              // CustomButtons(
                              //   title: 'Share',
                              //   icon: Icons.share,
                              //   onTap: () {
                              //     MySharePlus.onShare(
                              //       context,
                              //       appointment,
                              //     );
                              //   },
                              // )
                            ],
                          ),
                        ],
                      )
                  ],
                ),
              ),
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
            ],
          ),
        ),

        // if (isBooked)
        //   Positioned(
        //     top: 10.sp,
        //     right: 10.sp,
        //     child: PopupMenuButton(
        //       iconColor: AppColors.white,
        //       onSelected: (value) {
        //         if (value == 'update') {
        //           CustomDialogue.showUpdateDialog(
        //             context,
        //             appointment: appointment,
        //             onUpdate: widget.onUpdate,
        //           );
        //         } else if (value == 'reSchedule') {
        //           Navigator.push(
        //             context,
        //             CupertinoPageRoute(
        //               builder: (context) => AppointmentBooking(
        //                 reSchedule: true,
        //                 appointment: appointment,
        //                 customer: customer,
        //                 consultant: consultant,
        //                 branch: branch,
        //               ),
        //             ),
        //           );
        //         } else if (value == 'share') {
        //           MySharePlus.onShare(
        //             context,
        //             appointment,
        //           );
        //         }
        //       },
        //       itemBuilder: (context) {
        //         return [
        //           PopupMenuItem(
        //             value: 'update',
        //             child: textWidget(text: 'Update'),
        //           ),
        //           PopupMenuItem(
        //             value: 'reSchedule',
        //             child: textWidget(text: 'Reschedule'),
        //           ),
        //           PopupMenuItem(
        //             value: 'share',
        //             child: textWidget(text: 'Share'),
        //           ),
        //         ];
        //       },
        //     ),
        //   )
      ],
    );
  }

  // static Future<void> reScheduleAppointment(
  //   BuildContext context,
  //   Appointment appointment,
  //   String date,
  //   String time,
  // ) async {
  //   try {
  //     Api api = Api(
  //       dio,
  //       baseUrl: Constants.baseUrl,
  //     );

  //     dynamic res = await api.reScheduleAppointment({
  //       "consultant_id": appointment.consultantId,
  //       "customer_id": appointment.customerId,
  //       "business_id": appointment.businessId,
  //       "schedule_time": time,
  //       "appointment_date": date,
  //       "id": appointment.appointmentId,
  //       "branch_id": appointment.branchId,
  //     });

  //     if (res['status'] == 200) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pop();
  //       CustomDialogue.message(context: context, message: res['message']);
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (_) => const HomeScreen()),
  //       );
  //       // onUpdate();
  //     } else {
  //       if (res.toString().contains('message')) {
  //         // ignore: use_build_context_synchronously
  //         CustomDialogue.message(context: context, message: res['message']);
  //       } else {
  //         // ignore: use_build_context_synchronously
  //         CustomDialogue.message(context: context, message: res['error']);
  //       }
  //     }
  //   } catch (e) {
  //     log('Something went wrong in Reschedule Appointment api $e');
  //     CustomDialogue.message(
  //         // ignore: use_build_context_synchronously
  //         context: context,
  //         message: 'Appointment not Rescheduled $e');
  //   }
  // }

  Map<String, dynamic> getUsersData(Appointment appointment) {
    final branches = GetLocalData.getBranches();
    final customers = GetLocalData.getCustomers();
    final consultants = GetLocalData.getConsultants();
    final businessData = GetLocalData.getBusiness();
    Branch? branch;
    Customer? customer;
    Consultant? consultant;
    Business? business;
    final tempBranch = branches
        .where(
          (element) => element.id.toString() == appointment.branchId,
        )
        .toList();
    if (tempBranch.isNotEmpty) {
      branch = tempBranch.first;
    }
    final tempCustomers = customers
        .where(
          (element) =>
              element.id.toString() == appointment.customerId.toString(),
        )
        .toList();

    if (tempCustomers.isNotEmpty) {
      customer = tempCustomers.first;
    }
    final tempConsultant = consultants
        .where(
          (element) =>
              element.id.toString() == appointment.consultantId.toString(),
        )
        .toList();
    if (tempConsultant.isNotEmpty) {
      consultant = tempConsultant.first;
    }
    final tempBusiness = businessData
        .where(
          (element) =>
              element.id.toString() == appointment.businessId.toString(),
        )
        .toList();
    if (tempBusiness.isNotEmpty) {
      business = tempBusiness.first;
    }

    Map<String, dynamic> usersData = {
      'customer': customer,
      'consultant': consultant,
      'branch': branch,
      'business': business,
    };
    return usersData;
  }

  Widget customTextButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
        alignment: Alignment.center,
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ), // Text color
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primaryTheme,
        ), // Background color

        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
            side: BorderSide(
              color: Colors.blueAccent,
            ), // Border color
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: textWidget(text: text),
      ),
    );
  }
}

class CustomButtons extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const CustomButtons({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.white,
          ),
          SizedBox(
            width: 5.sp,
          ),
          textWidget(
            text: title,
            fWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
