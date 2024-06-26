import 'dart:developer';
import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_branches.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_schedule.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignConsultantSchedule extends StatefulWidget {
  final int? consultantId;
  final ConsultantSchedule? consultantSchedule;
  final bool updateSchedule;
  const AssignConsultantSchedule({
    super.key,
    this.consultantId,
    this.consultantSchedule,
    required this.updateSchedule,
  });

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

  String? selectedDay;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  bool isEdit = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    multipleDays.value.clear();
    super.dispose();
  }

  final multipleDays = ValueNotifier<List<String?>>([]);
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
              text: '${isEdit ? 'Update' : 'Assign'} Consultant Schedule',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                if (isEdit) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: consultants.isEmpty
              ? Center(
                  child: textWidget(
                    text: 'No consultant found to assign schedule',
                    fWeight: FontWeight.bold,
                  ),
                )
              : branches.isEmpty
                  ? Center(
                      child: textWidget(
                        text: 'No branch found to assign schedule',
                        fWeight: FontWeight.bold,
                      ),
                    )
                  : Form(
                      key: formKey,
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                            dropdownColor: AppColors.white,
                                            value: selectedConsultant,
                                            hint: Text(
                                              'Select consultant',
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                            style: MyTextStyles.smallBlacktext,
                                            isExpanded: true,
                                            items: consultants
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
                                            onChanged: (Consultant? value) {
                                              if (value != null) {
                                                if (isEdit) {
                                                  CustomDialogue.message(
                                                      context: context,
                                                      message:
                                                          'You cannot change consultant');
                                                } else {
                                                  selectedConsultant = value;

                                                  setState(() {});
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
                                          text: 'Business Branch',
                                          fSize: 14.sp,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: DropdownButton<Branch?>(
                                            dropdownColor: AppColors.white,
                                            value: selectedBranch,
                                            hint: Text(
                                              'Select branch',
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                            style: MyTextStyles.smallBlacktext,
                                            isExpanded: true,
                                            items: branches
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.address!,
                                                      style: MyTextStyles
                                                          .smallBlacktext,
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
                                                  style: MyTextStyles
                                                      .smallBlacktext
                                                      .copyWith(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Text(
                                                  '${selectedBranch!.startTime}',
                                                  style: MyTextStyles
                                                      .smallBlacktext
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
                                                  style: MyTextStyles
                                                      .smallBlacktext
                                                      .copyWith(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Text(
                                                  ' ${selectedBranch!.endTime}',
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
                                    if (multipleDays.value.isNotEmpty)
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: ValueListenableBuilder(
                                          valueListenable: multipleDays,
                                          builder: (context,
                                              List<String?> value, child) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.sp),
                                              child: Row(
                                                children: [
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: value
                                                        .map((String? e) =>
                                                            Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 5
                                                                            .sp,
                                                                        vertical: 5
                                                                            .sp),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 5
                                                                            .sp,
                                                                        vertical: 5
                                                                            .sp),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: AppColors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.2),
                                                                ),
                                                                child: Wrap(
                                                                  children: [
                                                                    textWidget(
                                                                        text:
                                                                            e!),
                                                                    SizedBox(
                                                                      width:
                                                                          5.sp,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        List<String?>
                                                                            tempMultipleAssignee =
                                                                            List.from(multipleDays.value);
                                                                        tempMultipleAssignee.removeWhere((element) =>
                                                                            element ==
                                                                            e);
                                                                        multipleDays.value =
                                                                            tempMultipleAssignee;
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        size: 20
                                                                            .sp,
                                                                        color: AppColors
                                                                            .black,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )))
                                                        .toList(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textWidget(
                                          text: "Days",
                                          fSize: 14.sp,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.07,
                                        ),
                                        Expanded(
                                          child: DropdownButton<String?>(
                                            dropdownColor: AppColors.white,
                                            value: selectedDay,
                                            hint: Text(
                                              'Select Day',
                                              style:
                                                  MyTextStyles.smallBlacktext,
                                            ),
                                            style: MyTextStyles.smallBlacktext,
                                            isExpanded: true,
                                            items: days
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                      style: MyTextStyles
                                                          .smallBlacktext,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (String? value) {
                                              if (value != null) {
                                                selectedDay = value;
                                                if (!isEdit) {
                                                  if (multipleDays
                                                      .value.isEmpty) {
                                                    multipleDays.value
                                                        .add(selectedDay);
                                                  } else {
                                                    if (!multipleDays.value.any(
                                                        (element) => element!
                                                            .contains(
                                                                selectedDay!))) {
                                                      multipleDays.value
                                                          .add(selectedDay);
                                                    }
                                                  }
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          selectedStartTime =
                                              await utils.selectTime(context);
                                          setState(() {});
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              selectedStartTime != null
                                                  ? selectedStartTime!
                                                      .toFormatted12Hours()
                                                  : 'Select Start time',
                                              style: MyTextStyles.smallBlacktext
                                                  .copyWith(
                                                color:
                                                    AppColors.black.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.black
                                                  .withOpacity(0.2),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              selectedEndTime != null
                                                  ? selectedEndTime!
                                                      .toFormatted12Hours()
                                                  : 'Select End time',
                                              style: MyTextStyles.smallBlacktext
                                                  .copyWith(
                                                color:
                                                    AppColors.black.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.black
                                                  .withOpacity(0.2),
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Builder(builder: (context) {
                                      if (isLoading) {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      return SizedBox(
                                        height: 40,
                                        child: RoundedElevatedButton(
                                          borderRadius: 6,
                                          onPressed: () {
                                            if (selectedConsultant != null &&
                                                selectedBranch != null &&
                                                selectedStartTime != null &&
                                                selectedEndTime != null &&
                                                selectedDay != null) {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                assignConsultantBranch();
                                              }
                                            } else if (selectedConsultant ==
                                                null) {
                                              CustomDialogue.message(
                                                  context: context,
                                                  message:
                                                      'Please Select Consultant');
                                            } else if (selectedBranch == null) {
                                              CustomDialogue.message(
                                                  context: context,
                                                  message:
                                                      'Please Select Branch');
                                            } else if (selectedDay == null) {
                                              CustomDialogue.message(
                                                  context: context,
                                                  message: 'Please Select Day');
                                            } else if (selectedStartTime ==
                                                null) {
                                              CustomDialogue.message(
                                                  context: context,
                                                  message:
                                                      'Please Select Start Time');
                                            } else if (selectedEndTime ==
                                                null) {
                                              CustomDialogue.message(
                                                  context: context,
                                                  message:
                                                      'Please Select End Time');
                                            }
                                          },
                                          text:
                                              '${isEdit ? 'Update' : 'Assign'} Schedule',
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
        dynamic res;
        String days;
        if (!isEdit) {
          days = multipleDays.value
              .map((e) => '$e')
              .toList()
              .toString()
              .replaceAll(',', '')
              .replaceAll('[', '')
              .replaceAll(']', '');
        } else {
          days = selectedDay!;
        }
        log('days ${days}');

        if (isEdit) {
          res = await api!.updateConsultantSchedule(
            {
              "branch_id": selectedBranch!.id.toString(),
              "start_time": selectedStartTime!.toFormatted12Hours(),
              "end_time": selectedEndTime!.toFormatted12Hours(),
              // "day": selectedDay,
              "day": days,
              "consultant_id": selectedConsultant!.id.toString(),
              "consultant_branch_id": selectedConsultantBranch!.cbid.toString(),
              "schedule_id": widget.consultantSchedule!.scheduledId,
            },
          );
        } else {
          res = await api!.assignConsultantBranchSchedule(
            {
              "branch_id": selectedBranch!.id.toString(),
              "start_time": selectedStartTime!.toFormatted12Hours(),
              "end_time": selectedEndTime!.toFormatted12Hours(),
              // "day": selectedDay,
              "day": days,
              "consultant_id": selectedConsultant!.id.toString(),
              "consultant_branch_id": selectedConsultantBranch!.cbid.toString(),
            },
          );
        }

        if (res['status'] == 200) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
          selectedStartTime = null;
          selectedEndTime = null;
          nameController.clear();
          addressController.clear();

          await Future.delayed(const Duration(seconds: 1));
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
      } else {
        if (isEdit) {
          CustomDialogue.message(
              // ignore: use_build_context_synchronously
              context: context,
              message: 'Schedule is not updated');
        } else {
          CustomDialogue.message(
              context: context,
              message:
                  'This branch is not assigned to ${selectedConsultant!.name}');
        }
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
    isEdit = widget.updateSchedule;
    consultants = GetLocalData.getConsultants();
    branches = GetLocalData.getBranches();

    if (isEdit) {
      selectedBranch = branches
          .where(
            (element) => element.id == widget.consultantSchedule!.branchId,
          )
          .first;
    }
    selectedConsultant = consultants
        .where(
          (element) => element.id == widget.consultantId,
        )
        .first;
    api ??= Api(
      dio,
      baseUrl: Constants.baseUrl,
    );
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    setState(() {
      isLoading = true;
    });

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
              (element) => element.branchId == selectedBranch!.id,
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
