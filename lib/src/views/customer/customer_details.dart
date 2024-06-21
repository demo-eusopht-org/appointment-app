import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Appointments/appointment_details.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/Customer/customer_history.dart';
import 'package:appointment_management/src/views/Customer/update_customer.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_container_patient.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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

class _CustomerDetailsState extends State<CustomerDetails>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDate;

  late Customer customer;

  dynamic user, businessId;

  List<Appointment>? customerAppointments;
  List<Appointment>? allAppointments;

  bool isLoading = false;

  bool isBooked = false;
  bool isConducted = false;
  bool isCancelled = false;

  Map<String, dynamic> statusOrder = {
    'Booked': 1,
    'Conducted': 2,
    'Cancelled': 3,
  };
  int selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _init();
    super.initState();
  }

  late TabController _tabController;
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
            if (!isLoading)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CustomerHistory(
                        customerAppointments: customerAppointments!,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.history,
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => UpdateCustomerProfile(
                      customer: customer,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: const Icon(
                  Icons.edit,
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
                        backgroundImage: customer.imageName != null
                            ? CachedNetworkImageProvider(
                                '${customer.imageName}',
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
                                            text: (customer.refrenceNo != '' &&
                                                    customer.refrenceNo != null)
                                                ? customer.refrenceNo!
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
                          label: 'Occupation:',
                          value: '${customer.occupation ?? '--'}',
                          color: AppColors.primary,
                          height: MediaQuery.of(context).size.width * 0.065,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                  isLoading ? const Loader() : const SizedBox(),
                  if (customerAppointments != null) appointmentsSchedule(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appointmentsSchedule() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedIndex = 0;
                    log('allAppointments ${allAppointments!.length}');
                    customerAppointments = allAppointments!
                        .where(
                          (element) =>
                              element.status!.toLowerCase() == 'booked',
                        )
                        .toList();
                    log('allAppointments ${allAppointments!.length}');
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? AppColors.primary
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: textWidget(
                      text: 'Schedule',
                      fWeight: FontWeight.w500,
                      color: selectedIndex == 0
                          ? AppColors.white
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedIndex = 1;
                    customerAppointments = allAppointments!
                        .where((element) =>
                            element.status!.toLowerCase() == 'conducted')
                        .toList();
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? AppColors.success
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: textWidget(
                      text: 'Conducted',
                      fWeight: FontWeight.w500,
                      color: selectedIndex == 1
                          ? AppColors.white
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedIndex = 2;
                    customerAppointments = allAppointments!
                        .where((element) =>
                            element.status!.toLowerCase() == 'cancelled')
                        .toList();
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == 2
                          ? AppColors.danger
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: textWidget(
                      text: 'Cancelled',
                      fWeight: FontWeight.w500,
                      color: selectedIndex == 2
                          ? AppColors.white
                          : AppColors.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.sp),
          if (customerAppointments != null && customerAppointments!.isEmpty)
            textWidget(
              text: 'No appointments schedule',
            ),
          SizedBox(
            height: 75.sp,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              dragStartBehavior: DragStartBehavior.start,
              itemCount: customerAppointments!.length,
              itemBuilder: (context, index) {
                sortAppointmentList();
                Appointment appointmentSchedule = customerAppointments![index];

                isBooked =
                    appointmentSchedule.status!.toLowerCase() == 'booked';
                isConducted =
                    appointmentSchedule.status!.toLowerCase() == 'conducted';
                isCancelled =
                    appointmentSchedule.status!.toLowerCase() == 'cancelled';
                return GestureDetector(
                  onTap: () {
                    final route = MaterialPageRoute(
                      builder: (context) => AppointmentDetails(
                          appointments: [customerAppointments![index]],
                          onUpdate: () async {}),
                    );
                    Navigator.push(context, route);
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
                        border: Border.all(color: AppColors.black),
                        color: isBooked
                            ? AppColors.primary
                            : isConducted
                                ? AppColors.success
                                : AppColors.danger,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                            text: appointmentSchedule.appointmentDate!
                                .toPkFormattedDate(),
                            color: Colors.white,
                            fWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          textWidget(
                            text: appointmentSchedule.scheduleTime!
                                .fromStringtoFormattedTime(),
                            color: Colors.white,
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
          allAppointments = res.appointments!
              .where((element) => element.customerId == customer.id)
              .toList();

          customerAppointments = allAppointments!
              .where((element) => element.status!.toLowerCase() == 'booked')
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
