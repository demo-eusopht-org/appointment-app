import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_business_branch/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/date_time_utils.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/customer/add_customer.dart';
import 'package:appointment_management/src/views/customer/customer_details.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/custom_dropdown.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/app_colors.dart';
import '../thankyou/thankyou_screen.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';

class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking({super.key});

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime? selectedDate;

  TimeOfDay? selectedTime;
  String? selectProcedure;
  bool isChecked = false;

  dynamic user, businessId;

  Api? api;

  GetCustomer? customerData;
  Customer? selectedCustomer;
  GetConsultant? consultantsData;
  Consultant? selectedConsultant;
  GetBranch? branchData;
  Branch? selectedBranch;

  List<Service>? services;
  Service? selectedService;
  bool isLoading = false;
  bool isAdding = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        title: 'Appointment Booking',
        leadingIcon: Icon(
          Icons.arrow_back_outlined,
        ),
        leadingIconOnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      drawer: CustomDrawer(),
      body: isLoading
          ? const Loader()
          : customerData == null
              ? Expanded(
                  child: Center(
                    child: textWidget(
                      text: 'No customer found for this business',
                      fWeight: FontWeight.bold,
                    ),
                  ),
                )
              : consultantsData == null
                  ? Expanded(
                      child: Center(
                        child: textWidget(
                          text: 'No consultant found for this business',
                          fWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 40),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                textWidget2(
                                  text: 'Customer',
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DropdownButton<Customer>(
                                    dropdownColor: AppColors.buttonColor,
                                    value: selectedCustomer,
                                    hint: Text(
                                      'Select customer',
                                      style: MyTextStyles.smallBlacktext,
                                    ),
                                    style: MyTextStyles.smallBlacktext,
                                    isExpanded: true,
                                    items: customerData!.customers!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name!,
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (Customer? value) {
                                      if (value != null) {
                                        selectedCustomer = value;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                textWidget2(
                                  text: 'Consultant',
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DropdownButton<Consultant?>(
                                    dropdownColor: AppColors.buttonColor,
                                    value: selectedConsultant,
                                    hint: Text(
                                      'Select consultant',
                                      style: MyTextStyles.smallBlacktext,
                                    ),
                                    style: MyTextStyles.smallBlacktext,
                                    isExpanded: true,
                                    items: consultantsData!.consultants
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name!,
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (Consultant? value) {
                                      if (value != null) {
                                        selectedConsultant = value;
                                        log('message ${selectedConsultant!.toJson()}');
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                textWidget2(
                                  text: 'Business Branch',
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DropdownButton<Branch?>(
                                    dropdownColor: AppColors.buttonColor,
                                    value: selectedBranch,
                                    hint: Text(
                                      'Select branch',
                                      style: MyTextStyles.smallBlacktext,
                                    ),
                                    style: MyTextStyles.smallBlacktext,
                                    isExpanded: true,
                                    items: branchData!.businessBranches!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.address!,
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (Branch? value) {
                                      if (value != null) {
                                        selectedBranch = value;
                                        log('message ${selectedBranch!.toJson()}');
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (selectedBranch != null)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.sp,
                                  vertical: 5.sp,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Branch Start time',
                                          style: MyTextStyles.smallBlacktext
                                              .copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          '${selectedBranch!.startTime}',
                                          style: MyTextStyles.smallBlacktext
                                              .copyWith(
                                            fontSize: 12.sp,
                                            // fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Branch End time',
                                          style: MyTextStyles.smallBlacktext
                                              .copyWith(
                                            fontSize: 12.sp,
                                            // fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          ' ${selectedBranch!.endTime}',
                                          style: MyTextStyles.smallBlacktext
                                              .copyWith(
                                            fontSize: 12.sp,
                                            // fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            Row(
                              children: [
                                textWidget2(
                                  text: 'Services',
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DropdownButton<Service?>(
                                    dropdownColor: AppColors.buttonColor,
                                    value: selectedService,
                                    hint: Text(
                                      'Select service',
                                      style: MyTextStyles.smallBlacktext,
                                    ),
                                    style: MyTextStyles.smallBlacktext,
                                    isExpanded: true,
                                    items: services!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.serviceName!,
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (Service? value) {
                                      if (value != null) {
                                        selectedService = value;
                                        log('selectedService=> ${selectedService!.toJson()}');
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget2(
                                  text: "Date",
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.07,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    height: 36,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.ratingbarColor,
                                      borderRadius: BorderRadius.circular(38),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        textWidget(
                                          text: selectedDate != null
                                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                              : 'Select Date',
                                          fSize: 12.sp,
                                          fWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.black,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget2(
                                  text: "Start Time",
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setState(() {
                                        selectedTime = pickedTime;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 36,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.ratingbarColor,
                                      borderRadius: BorderRadius.circular(38),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        textWidget(
                                          text: selectedTime != null
                                              ? selectedTime!.format(context)
                                              : 'Select Time',
                                          fSize: 12.sp,
                                          fWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                textWidget2(
                                  text: "Share On WhatsApp",
                                  fSize: 14.sp,
                                  fWeight: FontWeight.bold,
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  visualDensity: VisualDensity.compact,
                                  activeColor: AppColors.buttonColor,
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide.none,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isChecked = newValue ?? false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            SizedBox(
                              height: 42,
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: RoundedElevatedButton(
                                borderRadius: 36,
                                onPressed: () {
                                  if (selectedCustomer == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please select customer');
                                  } else if (selectedConsultant == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please select consultant');
                                  } else if (selectedBranch == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message:
                                            'Please select business branch');
                                  } else if (selectedService == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please select service');
                                  } else if (selectedDate == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please select date');
                                  } else if (selectedTime == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please select start time');
                                  } else {
                                    addAppointment();
                                  }
                                },
                                text: "Add Appointment",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
    );
  }

  Future<void> _init() async {
    api ??= Api(
      dio,
      baseUrl: Constants.baseUrl,
    );
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    setState(() {
      isLoading = true;
    });
    await getCustomerData();
    await getConsultantData();
    await getBusinessBranch();

    services = GetLocalData.getServices();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getCustomerData() async {
    GetCustomer? tempCustomer = await ApiServices.getCustomer(
      context,
      Constants.getCustomers + businessId.toString(),
      user,
    );

    if (tempCustomer != null) {
      customerData = tempCustomer;
    }
  }

  Future<void> getConsultantData() async {
    GetConsultant? tempConsultant = await ApiServices.getConsultant(
      context,
      Constants.getBusiness + businessId.toString(),
      user,
    );

    if (tempConsultant != null) {
      consultantsData = tempConsultant;
    }
    setState(() {});
  }

  Future<void> getBusinessBranch() async {
    GetBranch? tempBranch = await ApiServices.getBusinessBranch(
      context,
      Constants.getBusinessBranch + businessId.toString(),
      user,
    );

    if (tempBranch != null) {
      branchData = tempBranch;
    }
    setState(() {});
  }

  Future<void> addAppointment() async {
    try {
      setState(() {
        isAdding = true;
      });

      dynamic res = await api!.createAppointment(
        {
          "consultant_id": selectedConsultant!.id,
          "customer_id": selectedCustomer!.id,
          "business_id": businessId,
          "schedule_time": selectedTime!.toFormattedTime(),
          "appointment_date": selectedDate!.toPkFormattedDate(),
          "branch_id": selectedBranch!.id,
        },
      );
      log('res service ${res}');
      log('res service ${res['status']}');

      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogue.message(context: context, message: res['message']);
      } else {
        if (res.toString().contains('message')) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
        } else {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
      setState(() {
        isAdding = false;
      });
    } catch (e) {
      setState(() {
        isAdding = false;
      });
      log('Something went wrong in create Appointment api $e');
      CustomDialogue.message(
          context: context, message: 'Appointment not created $e');
    }
  }
}
