import 'dart:developer';
import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_branches.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignConsultantSchedule extends StatefulWidget {
  const AssignConsultantSchedule({super.key});

  @override
  State<AssignConsultantSchedule> createState() => AssigneBranchState();
}

class AssigneBranchState extends State<AssignConsultantSchedule> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  Api? api;

  dynamic user, businessId;

  List<Consultant> consultants = [];
  List<Branch> branches = [];

  Branch? selectedBranch;

  Consultant? selectedConsultant;

  ConsultantBranch? selectedConsultantBranch;

  DateTime? selectedDate;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: textWidget(
              text: 'Assign Consultant Schedule',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              textWidget(
                                text: 'Consultant',
                                fSize: 14.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownButton<Consultant?>(
                                  dropdownColor: AppColors.primary,
                                  value: selectedConsultant,
                                  hint: Text(
                                    'Select consultant',
                                    style: MyTextStyles.smallBlacktext,
                                  ),
                                  style: MyTextStyles.smallBlacktext,
                                  isExpanded: true,
                                  items: consultants
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.name!,
                                            style: MyTextStyles.smallBlacktext,
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
                              textWidget(
                                text: 'Business Branch',
                                fSize: 14.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownButton<Branch?>(
                                  dropdownColor: AppColors.primary,
                                  value: selectedBranch,
                                  hint: Text(
                                    'Select branch',
                                    style: MyTextStyles.smallBlacktext,
                                  ),
                                  style: MyTextStyles.smallBlacktext,
                                  isExpanded: true,
                                  items: branches
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.address!,
                                            style: MyTextStyles.smallBlacktext,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (Branch? value) {
                                    if (value != null) {
                                      selectedBranch = value;

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
                                        ),
                                      ),
                                      Text(
                                        ' ${selectedBranch!.endTime}',
                                        style: MyTextStyles.smallBlacktext
                                            .copyWith(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () async {
                                selectedStartTime =
                                    await utils.selectTime(context);
                                setState(() {});
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedStartTime != null
                                        ? selectedStartTime!.toFormattedTime()
                                        : 'Select Start time',
                                    style: MyTextStyles.smallBlacktext.copyWith(
                                      color: AppColors.black.withOpacity(
                                        0.5,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(0.2),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () async {
                                selectedEndTime =
                                    await utils.selectTime(context);

                                setState(() {});
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedEndTime != null
                                        ? selectedEndTime!.toFormattedTime()
                                        : 'Select End time',
                                    style: MyTextStyles.smallBlacktext.copyWith(
                                      color: AppColors.black.withOpacity(
                                        0.5,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(0.2),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget(
                                text: "Date",
                                fSize: 14.sp,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.07,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  selectedDate =
                                      await utils.selectDate(context);

                                  setState(() {});
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
                            height: 10,
                          ),
                          Builder(builder: (context) {
                            if (isLoading) {
                              return const Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Container(
                              height: 40,
                              child: RoundedElevatedButton(
                                borderRadius: 6,
                                onPressed: () {
                                  if (selectedConsultant != null &&
                                      selectedBranch != null &&
                                      selectedStartTime != null &&
                                      selectedEndTime != null &&
                                      selectedDate != null) {
                                    if (formKey.currentState!.validate()) {
                                      assignConsultantBranch();
                                    }
                                  } else if (selectedConsultant == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select Consultant');
                                  } else if (selectedBranch == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select Branch');
                                  } else if (selectedStartTime == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select Start Time');
                                  } else if (selectedEndTime == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select End Time');
                                  } else if (selectedDate == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select Date');
                                  }
                                },
                                text: 'Assign Schedule',
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: SafeArea(
            child: Image.asset(
              "assets/images/add_consultant_vector10.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> assignConsultantBranch() async {
    try {
      setState(() {
        isLoading = true;
      });
      await getConsultantBranches();

      if (selectedConsultantBranch != null) {
        dynamic res = await api!.assignConsultantBranchSchedule(
          {
            "branch_id": selectedBranch!.id,
            "start_time": selectedStartTime!.toFormattedTime(),
            "end_time": selectedEndTime!.toFormattedTime(),
            "day": selectedDate!.convertDateToDay(),
            "consultant_id": selectedConsultant!.id,
            "consultant_branch_id": selectedConsultantBranch!.id,
          },
        );

        if (res['status'] == 200) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
          selectedStartTime = null;
          selectedEndTime = null;
          nameController.clear();
          addressController.clear();
        } else {
          if (res.toString().contains('message')) {
            // ignore: use_build_context_synchronously
            CustomDialogue.message(context: context, message: res['message']);
          } else {
            // ignore: use_build_context_synchronously
            CustomDialogue.message(context: context, message: res['error']);
          }
        }
      } else {
        CustomDialogue.message(
            context: context,
            message:
                'This branch is not assigned to ${selectedConsultant!.name}');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Something went wrong in assign branch api $e');
      CustomDialogue.message(
          // ignore: use_build_context_synchronously
          context: context,
          message: 'Branch not assigned $e');
    }
  }

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

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

    consultants = GetLocalData.getConsultants();
    branches = GetLocalData.getBranches();
    // await getConsultantBranches();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getConsultantBranches() async {
    try {
      final res = await ApiServices.getConsultantBranches(
        context,
        Constants.getConsultantBranches + selectedConsultant!.id.toString(),
        user,
      );

      if (res != null) {
        selectedConsultantBranch = null;
        final tempConsultantBranch = res.consultant!
            .where(
              (element) => element.cbid == selectedBranch!.id,
            )
            .toList();
        if (tempConsultantBranch.isNotEmpty) {
          selectedConsultantBranch = tempConsultantBranch.first;
        }
      }
    } catch (e, stack) {
      log('Something went wrong in getConsultantBranches Api $e',
          stackTrace: stack);
    }
  }
}
