import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_business_branch/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/home/home_screen.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/custom_textfield.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:appointment_management/src/utils/date_time_utils.dart';

class AssignBranch extends StatefulWidget {
  const AssignBranch({super.key});

  @override
  State<AssignBranch> createState() => AssigneBranchState();
}

class AssigneBranchState extends State<AssignBranch> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  Api? api;

  dynamic user, businessId;

  List<Service> services = [];
  List<Consultant> consultants = [];
  List<Branch> branches = [];

  Branch? selectedBranch;

  Consultant? selectedConsultant;

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
              text: 'Assign Branch',
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
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body:
              // findingConsultant
              //     ? Loader()
              //     : consultantsData == null
              //         ? Center(
              //             child: textWidget(
              //               text: 'No consultant found to assign customer',
              //               fWeight: FontWeight.bold,
              //             ),
              //           )
              //         :
              Form(
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
                                      log('message ${selectedBranch!.toJson()}');
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
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
                                      selectedBranch != null) {
                                    if (formKey.currentState!.validate()) {
                                      assignBranch();
                                    }
                                  } else if (selectedConsultant == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select Consultant');
                                  } else if (selectedBranch == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please Select Branch');
                                  }
                                },
                                text: 'Assign branch',
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

  Future<void> assignBranch() async {
    try {
      setState(() {
        isLoading = true;
      });

      dynamic res = await api!.assignBranch(
        {
          "consultant_id": selectedConsultant!.id,
          "business_id": businessId,
          "branch_id": [selectedBranch!.id]
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
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Something went wrong in assign branch api $e');
      CustomDialogue.message(
          context: context, message: 'Branch not assigned $e');
    }
  }

  // Future<void> getConsultantData() async {
  //   try {
  //     final res = await ApiServices.getConsultant(
  //       context,
  //       Constants.getBusiness + businessId.toString(),
  //       user,
  //     );
  //     if (res != null) {
  //       consultantsData = res;
  //     }
  //     setState(() {
  //       findingConsultant = false;
  //     });
  //   } catch (e) {
  //     log('Something went wrong in getConsultant Api $e');
  //     setState(() {
  //       findingConsultant = false;
  //     });
  //   }
  // }

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

    services = GetLocalData.getServices();
    consultants = GetLocalData.getConsultants();
    branches = GetLocalData.getBranches();

    setState(() {
      isLoading = false;
    });
  }
}
