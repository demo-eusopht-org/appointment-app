import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_schedule.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/services/share_service.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/customer/add_customer.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_colors.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';

class AppointmentBooking extends StatefulWidget {
  final bool reSchedule;
  final Appointment? appointment;
  final Customer? customer;
  final Consultant? consultant;
  final Branch? branch;
  const AppointmentBooking({
    super.key,
    required this.reSchedule,
    this.appointment,
    this.customer,
    this.consultant,
    this.branch,
  });

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

  // GetCustomer? customerData;
  Customer? selectedCustomer;
  // GetConsultant? consultantsData;
  Consultant? selectedConsultant;

  // GetBranch? branchData;
  Branch? selectedBranch;

  List<Service>? services;
  List<Customer>? customers;
  List<Consultant>? consultants;
  Service? selectedService;
  bool isLoading = false;
  bool isAddingAppointment = false;

  List<Branch>? branches;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<ConsultantSchedule>? consultantSchedule;
  ConsultantSchedule? selectedConsultantSchedule;
  String? selectedDay;

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
        title: 'Appointment ${widget.reSchedule ? 'Reschedule' : 'Booking'}',
        leadingIcon: const Icon(
          Icons.arrow_back_outlined,
        ),
        leadingIconOnTap: () {
          if (widget.reSchedule) {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
      ),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Loader()
          : customers!.isEmpty
              ? Center(
                  child: textWidget(
                    text: 'No Customer found to set appointment',
                    fWeight: FontWeight.bold,
                  ),
                )
              : consultants!.isEmpty
                  ? Center(
                      child: textWidget(
                        text: 'No Consutant found to set appointment',
                        fWeight: FontWeight.bold,
                      ),
                    )
                  : branches!.isEmpty
                      ? Center(
                          child: textWidget(
                            text: 'No Business Branch found, Please create one',
                            fWeight: FontWeight.bold,
                          ),
                        )
                      : services!.isEmpty
                          ? Center(
                              child: textWidget(
                                text: 'No Service found, Please create one',
                                fWeight: FontWeight.bold,
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
                                        textWidget(
                                          text: 'Customer',
                                          fSize: 14.sp,
                                          fWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: DropdownButton<Customer>(
                                            dropdownColor: AppColors.white,
                                            iconEnabledColor: AppColors.primary,
                                            value: selectedCustomer,
                                            hint: Text(
                                              'Select customer',
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                            style: MyTextStyles.smallBlacktext,
                                            isExpanded: true,
                                            items: customers!
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.email!,
                                                      style: MyTextStyles
                                                          .smallBlacktext,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (Customer? value) {
                                              if (value != null) {
                                                if (!widget.reSchedule) {
                                                  selectedCustomer = value;
                                                  setState(() {});
                                                } else {
                                                  CustomDialogue.message(
                                                      context: context,
                                                      message:
                                                          'You cannot change the customer');
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        textWidget(
                                          text: 'Consultant',
                                          fSize: 14.sp,
                                          fWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          width: 10.sp,
                                        ),
                                        Expanded(
                                          child: DropdownButton<Consultant?>(
                                            dropdownColor: AppColors.white,
                                            iconEnabledColor: AppColors.primary,
                                            value: selectedConsultant,
                                            hint: Text(
                                              'Select consultant',
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                            style: MyTextStyles.smallBlacktext,
                                            isExpanded: true,
                                            items: consultants!
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.email!,
                                                      style: MyTextStyles
                                                          .smallBlacktext,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged:
                                                (Consultant? value) async {
                                              if (value != null) {
                                                if (widget.reSchedule) {
                                                  CustomDialogue.message(
                                                      context: context,
                                                      message:
                                                          'You cannot change the consultant');
                                                } else {
                                                  consultantSchedule = null;
                                                  selectedConsultantSchedule =
                                                      null;
                                                  selectedDay = null;
                                                  selectedBranch = null;
                                                  selectedConsultant = value;

                                                  setState(() {});
                                                  await getConsultantSchedule();
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (consultantSchedule != null &&
                                        consultantSchedule!.isNotEmpty)
                                      Row(
                                        children: [
                                          textWidget(
                                            text: 'Consultant Branch',
                                            fSize: 14.sp,
                                            fWeight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            width: 10.sp,
                                          ),
                                          Expanded(
                                            child: DropdownButton<Branch?>(
                                              dropdownColor: AppColors.white,
                                              iconEnabledColor:
                                                  AppColors.primary,
                                              value: selectedBranch,
                                              hint: Text(
                                                'Select branch',
                                                style:
                                                    MyTextStyles.smallBlacktext,
                                              ),
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                              isExpanded: true,
                                              items: branches!
                                                  .where((branch) {
                                                    return consultantSchedule!
                                                        .any((element) =>
                                                            element.branchId ==
                                                            branch.id);
                                                  })
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e.address!
                                                            .toUpperCaseFirst(),
                                                        style: MyTextStyles
                                                            .smallBlacktext,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (Branch? value) {
                                                if (value != null) {
                                                  selectedConsultantSchedule =
                                                      null;
                                                  selectedDay = null;
                                                  selectedBranch = null;
                                                  selectedBranch = value;

                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (consultantSchedule != null &&
                                        consultantSchedule!.isEmpty)
                                      const Text(
                                          'No Branch or Schedule assigned to this Consultant, Please assign Branch and Schedule'),
                                    if (selectedBranch != null)
                                      Row(
                                        children: [
                                          textWidget(
                                            text: 'Consultant Day',
                                            fSize: 14.sp,
                                            fWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: DropdownButton<
                                                ConsultantSchedule?>(
                                              dropdownColor: AppColors.white,
                                              iconEnabledColor:
                                                  AppColors.primary,
                                              value: selectedConsultantSchedule,
                                              hint: Text(
                                                'Select Day',
                                                style:
                                                    MyTextStyles.smallBlacktext,
                                              ),
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                              isExpanded: true,
                                              items: consultantSchedule!
                                                  .where((element) =>
                                                      element.branchId ==
                                                      selectedBranch!.id)
                                                  .map(
                                                (e) {
                                                  return DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.day!,
                                                      style: MyTextStyles
                                                          .smallBlacktext,
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (ConsultantSchedule?
                                                  value) async {
                                                if (value != null) {
                                                  selectedConsultantSchedule =
                                                      value;
                                                  selectedDay =
                                                      selectedConsultantSchedule!
                                                          .day;

                                                  log('selectedConsultantSchedule ${selectedConsultantSchedule!.toJson()}');

                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (selectedDay != null)
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
                                                  'Consultant Start Time',
                                                  style: MyTextStyles
                                                      .smallBlacktext
                                                      .copyWith(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Text(
                                                  '${selectedConsultantSchedule!.startTime}',
                                                  style: MyTextStyles
                                                      .smallBlacktext
                                                      .copyWith(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Consultant End time',
                                                  style: MyTextStyles
                                                      .smallBlacktext
                                                      .copyWith(
                                                    fontSize: 12.sp,
                                                    // fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  '${selectedConsultantSchedule!.endTime}',
                                                  style: MyTextStyles
                                                      .smallBlacktext
                                                      .copyWith(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        textWidget(
                                          text: 'Services',
                                          fSize: 14.sp,
                                          fWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: DropdownButton<Service?>(
                                            dropdownColor: AppColors.white,
                                            iconEnabledColor: AppColors.primary,
                                            value: selectedService,
                                            hint: Text(
                                              'Select service',
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                            style: MyTextStyles.smallBlacktext,
                                            isExpanded: true,
                                            items: services!
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.serviceName!
                                                          .toUpperCaseFirst(),
                                                      style: MyTextStyles
                                                          .smallBlacktext,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textWidget(
                                          text: "Date",
                                          fSize: 14.sp,
                                          fWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.07,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (widget.reSchedule) {
                                              CustomDialogue.message(
                                                  context: context,
                                                  message:
                                                      'You cannot change the date');
                                            } else {
                                              if (selectedDay != null) {
                                                selectedDate = await utils
                                                    .customDatePicker(
                                                        context, selectedDay!);
                                              } else {
                                                CustomDialogue.message(
                                                    context: context,
                                                    message:
                                                        'Please select day');
                                              }

                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            height: 36,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.ratingbarColor,
                                              borderRadius:
                                                  BorderRadius.circular(38),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                textWidget(
                                                  text: selectedDate != null
                                                      ? selectedDate!
                                                          .toPkFormattedDate()
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textWidget(
                                          text: "Start Time",
                                          fSize: 14.sp,
                                          fWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            selectedTime =
                                                await utils.selectTime(context);
                                            log(' scheduleTime ${selectedTime}');

                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 36,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.ratingbarColor,
                                              borderRadius:
                                                  BorderRadius.circular(38),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                textWidget(
                                                  text: selectedTime != null
                                                      ? selectedTime!
                                                          .format(context)
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
                                        textWidget(
                                          text: "Share Appointment",
                                          fSize: 14.sp,
                                          fWeight: FontWeight.bold,
                                        ),
                                        Checkbox(
                                          checkColor: Colors.white,
                                          visualDensity: VisualDensity.compact,
                                          activeColor: AppColors.primary,
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
                                    isAddingAppointment
                                        ? const Loader()
                                        : SizedBox(
                                            height: 42,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.6,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.primary,
                                                ),
                                                onPressed: () {
                                                  if (selectedCustomer ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select customer');
                                                  } else if (selectedConsultant ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select consultant');
                                                  } else if (selectedBranch ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select business branch');
                                                  } else if (selectedDay ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select day');
                                                  } else if (selectedService ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select service');
                                                  } else if (selectedDate ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select date');
                                                  } else if (selectedTime ==
                                                      null) {
                                                    CustomDialogue.message(
                                                        context: context,
                                                        message:
                                                            'Please select start time');
                                                  } else {
                                                    addAppointment();
                                                  }
                                                },
                                                child: textWidget(
                                                  text:
                                                      "${widget.reSchedule ? 'Reschedule' : 'Add'} Appointment",
                                                  fSize: 12.sp,
                                                  fWeight: FontWeight.w500,
                                                  color: AppColors.white,
                                                )),
                                          ),
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
    customers = GetLocalData.getCustomers();
    consultants = GetLocalData.getConsultants();
    services = GetLocalData.getServices();
    branches = GetLocalData.getBranches();
    if (widget.reSchedule) {
      selectedCustomer = customers!
          .where(
            (element) => element.id == widget.customer!.id,
          )
          .first;
      selectedConsultant = consultants!
          .where(
            (element) => element.id == widget.consultant!.id,
          )
          .first;

      await getConsultantSchedule();

      selectedBranch = branches!
          .where(
            (element) => element.id == widget.branch!.id,
          )
          .first;

      selectedDate = widget.appointment!.appointmentDate;

      final tempScheduleTime = widget.appointment!.scheduleTime!.split(':');

      selectedTime = TimeOfDay(
          hour: int.parse(tempScheduleTime[0]),
          minute: int.parse(tempScheduleTime[1]));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> addAppointment() async {
    try {
      setState(() {
        isAddingAppointment = true;
      });
      dynamic res;
      if (widget.reSchedule) {
        res = await api!.reScheduleAppointment({
          "consultant_id": selectedConsultant!.id,
          "customer_id": selectedCustomer!.id,
          "business_id": businessId,
          "schedule_time": selectedTime!.toFormatted12Hours(),
          "appointment_date": selectedDate!.toFormattedDate(),
          "id": widget.appointment!.appointmentId,
          "branch_id": selectedBranch!.id,
        });
        log('i m here widget.reSchedule ${res}');
      } else {
        res = await api!.createAppointment(
          {
            "consultant_id": selectedConsultant!.id,
            "customer_id": selectedCustomer!.id,
            "business_id": businessId,
            "schedule_time": selectedTime!.toFormatted12Hours(),
            "appointment_date": selectedDate!.toFormattedDate(),
            "branch_id": selectedBranch!.id,
          },
        );
      }

      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogue.message(context: context, message: res['message']);
        await Future.delayed(const Duration(seconds: 1));
        if (isChecked) {
          shareAppointment();
        }
        final route = CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
        Navigator.push(context, route);
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
        isAddingAppointment = false;
      });
    } catch (e) {
      setState(() {
        isAddingAppointment = false;
      });
      log('Something went wrong in create Appointment api $e');
      CustomDialogue.message(
          context: context,
          message:
              'Appointment not ${widget.reSchedule ? 'updated' : 'created'} $e');
    }
  }

  Future<void> getConsultantSchedule() async {
    GetConsultantSchedule? tempConsutlantSchedule =
        await ApiServices.getConsultantSchedule(
      context,
      Constants.getConsultantSchedule +
          (widget.reSchedule
              ? widget.consultant!.id.toString()
              : selectedConsultant!.id.toString()),
      user,
    );

    if (tempConsutlantSchedule != null) {
      if (tempConsutlantSchedule.consultantSchedule!.isNotEmpty &&
          tempConsutlantSchedule.consultantSchedule!.first.cbid != null) {
        consultantSchedule = tempConsutlantSchedule.consultantSchedule;
      } else {
        consultantSchedule = [];
      }
    } else {
      consultantSchedule = [];
    }
    log('consultantSchedule=> ${consultantSchedule!.length}');

    setState(() {});
  }

  void shareAppointment() {
    final startTime =
        utils.mergeTime(selectedDate!, selectedTime!.toFormatted24Hours());

    final endTime = startTime.add(const Duration(minutes: 30));

    MySharePlus.onShare(
      context,
      Appointment(
        start: startTime,
        end: endTime,
        consultantId: selectedConsultant!.id,
        customerId: selectedCustomer!.id,
        businessId: businessId,
        branchId: selectedBranch!.id.toString(),
        appointmentDate: selectedDate!,
      ),
    );
  }
}
