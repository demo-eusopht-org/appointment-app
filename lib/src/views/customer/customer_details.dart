import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/customer/customer_history.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_container_patient.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';

class CustomerDetails extends StatefulWidget {
  final Customer customer;
  const CustomerDetails({super.key, required this.customer});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  // int selectedDateIndex = 0;
  // int selectedTimeIndex = 0;
  DateTime? selectedDate;

  late Customer customer;

  dynamic user, businessId;

  List<Appointment>? customerAppointments;

  bool isLoading = false;

  bool isBooked = false;
  bool isConducted = false;
  bool isCancelled = false;

  Map<String, dynamic> statusOrder = {
    'Booked': 1,
    'Conducted': 2,
    'Cancelled': 3,
  };

  @override
  void initState() {
    _init();
    super.initState();
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
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: 'Customer Details ',
          action: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PatientHistory(
                      customerAppointments: customerAppointments!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: const Icon(
                  Icons.history,
                ),
              ),
            ),
          ]),
      body: Stack(
        children: [
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Image.asset(
          //     AppImages.vectorBox,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35.sp,
                        backgroundImage: customer.imagename != null
                            ? CachedNetworkImageProvider(
                                '${customer.imagename}',
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
                            text: '${customer.name}',
                            fWeight: FontWeight.w700,
                          ),
                          textWidget(
                            text: '${customer.email}',
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.sp),
                                      child: Column(
                                        children: [
                                          textWidget(
                                            text: 'Mobile No.',
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          textWidget(
                                            text: customer.mobile ?? '--',
                                            fWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.sp),
                                      child: Column(
                                        children: [
                                          textWidget(
                                            text: 'Reference ',
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          textWidget(
                                            text: (customer.refrenceno != '' &&
                                                    customer.refrenceno != null)
                                                ? customer.refrenceno!
                                                : '--',
                                            fWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    child: Divider(
                      color: AppColors.black.withOpacity(0.3),
                      height: 2.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.sp, right: 5.sp),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.sp,
                              horizontal: 10.sp,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.primary,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                  text: 'Address:',
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: textWidget(
                                    text: customer.address ?? '--',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // textWidget(
                        //   text: 'Note:',
                        //   fWeight: FontWeight.w700,
                        //   color: Colors.black,
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // textWidget(
                        //   text:
                        //       'Ive been making efforts to stay active and eat healthier to improve my overall well-being.',
                        //   color: Colors.black,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        CustomInfoContainer(
                          label: 'Age:',
                          value: '${customer.age ?? '--'}',
                          color: AppColors.primary,
                          height: MediaQuery.of(context).size.width * 0.065,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInfoContainer(
                          label: 'Height:',
                          value: '${customer.height ?? '--'}',
                          color: AppColors.primary,
                          height: MediaQuery.of(context).size.width * 0.067,
                          width: MediaQuery.of(context).size.width * 0.33,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInfoContainer(
                          label: 'D.O.B:',
                          value: customer.dob != null
                              ? customer.dob!.toPkFormattedDate()
                              : '--',
                          color: AppColors.primary,
                          height: MediaQuery.of(context).size.width * 0.069,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    ),
                  ),
                  isLoading ? Loader() : SizedBox(),
                  if (customerAppointments != null &&
                      customerAppointments!.isEmpty)
                    textWidget(
                      text: 'No appointments schedule',
                    ),
                  if (customerAppointments != null &&
                      customerAppointments!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget(
                                text: 'Appointment Date and Time',
                                fWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  textWidget(
                                    text: 'Schedule',
                                    fWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  CircleAvatar(
                                    radius: 5.sp,
                                    backgroundColor: AppColors.primary,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  textWidget(
                                    text: 'Conducted',
                                    fWeight: FontWeight.w500,
                                    color: AppColors.success,
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  CircleAvatar(
                                    radius: 5.sp,
                                    backgroundColor: AppColors.success,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  textWidget(
                                    text: 'Cancelled',
                                    fWeight: FontWeight.w500,
                                    color: AppColors.danger,
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  CircleAvatar(
                                    radius: 5.sp,
                                    backgroundColor: AppColors.danger,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10.sp),
                          SizedBox(
                            height: 75.sp,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: customerAppointments!.length,
                              itemBuilder: (context, index) {
                                // bool isSelected = (index == selectedDateIndex);

                                sortAppointmentList();
                                Appointment appointmentSchedule =
                                    customerAppointments![index];

                                isBooked =
                                    appointmentSchedule.status!.toLowerCase() ==
                                        'booked';
                                isConducted =
                                    appointmentSchedule.status!.toLowerCase() ==
                                        'conducted';
                                isCancelled =
                                    appointmentSchedule.status!.toLowerCase() ==
                                        'cancelled';
                                return GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   selectedDateIndex = index;
                                    // });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                        vertical: 10.sp,
                                      ),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.black),
                                        color:
                                            // isSelected ?
                                            isBooked
                                                ? AppColors.primary
                                                : isConducted
                                                    ? AppColors.success
                                                    : AppColors.danger,
                                        // :   AppColors.ratingbarColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          textWidget(
                                            text: appointmentSchedule
                                                .appointmentDate!
                                                .toPkFormattedDate(),
                                            color:
                                                // isSelected ?
                                                Colors.white,
                                            // : Colors.black,
                                            fWeight: FontWeight.w700,
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          textWidget(
                                            text: appointmentSchedule
                                                .scheduleTime!
                                                .fromStringtoFormattedTime(),
                                            color:
                                                //  isSelected     ?
                                                Colors.white,
                                            // : Colors.black,
                                            fWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCustomerAppointments(Customer customer) async {
    try {
      final res = await ApiServices.getAllAppointments(
        context,
        Constants.getAllAppointments + businessId.toString(),
        user,
      );

      if (res != null) {
        if (res.appointments!.isNotEmpty) {
          for (var i = 0; i < res.appointments!.length; i++) {
            log('res.appointments ${res.totalAppointments}');
          }
          customerAppointments = res.appointments!
              .where((element) => element.customerId == customer.id)
              .toList();
        }
      }
    } catch (e, stack) {
      log('Something went wrong in getCustomerAppointments Api $e',
          stackTrace: stack);
    }
  }

  Future<void> _init() async {
    setState(() {
      isLoading = true;
    });
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    customer = widget.customer;
    await getCustomerAppointments(customer);
    setState(() {
      isLoading = false;
    });
  }

  void sortAppointmentList() {
    customerAppointments!.sort(
      (a, b) {
        final orderA = statusOrder[a.status];
        final orderB = statusOrder[b.status];
        return orderA.compareTo(orderB);
      },
    );
  }
}
