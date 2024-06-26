// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/custom_textfield.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:appointment_management/src/utils/extensions.dart';

class CreateBranch extends StatefulWidget {
  const CreateBranch({super.key});

  @override
  State<CreateBranch> createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  Api? api;

  // bool findingConsultant = true;
  // GetConsultant? consultantsData;
  // ValueNotifier<String?> selectedConsultantId = ValueNotifier<String?>(null);

  dynamic user, businessId;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
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
              text: 'Create Branch',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
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
                          CustomTextField(
                            hintText: "Address",
                            controller: addressController,
                          ),
                          const SizedBox(
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
                                        ? selectedStartTime!
                                            .toFormatted12Hours()
                                        : 'Select Branch Start time',
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
                                        ? selectedEndTime!.toFormatted12Hours()
                                        : 'Select Branch End time',
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
                                  // if (selectedConsultantId.value != null) {
                                  if (selectedStartTime != null &&
                                      selectedEndTime != null) {
                                    if (formKey.currentState!.validate()) {
                                      addBranch();
                                    }
                                  } else if (selectedStartTime == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Add Branch start time');
                                  } else if (selectedEndTime == null) {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Add Branch end time');
                                  }
                                },
                                text: 'Create branch',
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

  Future<void> addBranch() async {
    try {
      setState(() {
        isLoading = true;
      });

      dynamic res = await api!.createBranch(
        {
          "business_id": businessId.toString(),
          "start_time": selectedStartTime!.toFormatted12Hours(),
          "end_time": selectedEndTime!.toFormatted12Hours(),
          "address": addressController.text,
        },
      );

      if (res['status'] == 200) {
        await getBusinessBranch();
        Navigator.pop(context, true);
      } else {
        if (res.toString().contains('message')) {
          CustomDialogue.message(context: context, message: res['message']);
        } else {
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
      log('Something went wrong in create branch api $e');
      CustomDialogue.message(
          context: context, message: 'Branch not created $e');
    }
  }

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  Future<void> _init() async {
    api ??= Api(
      dio,
      baseUrl: Constants.baseUrl,
    );
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    user = locator<LocalStorageService>().getData(key: 'user');
  }

  Future<void> getBusinessBranch() async {
    GetBranch? tempBranch = await ApiServices.getBusinessBranch(
      context,
      Constants.getBusinessBranch + businessId.toString(),
      user,
    );

    if (tempBranch != null) {
      if (tempBranch.businessBranches!.isNotEmpty) {
        await locator<LocalStorageService>().delete('branches');
        await locator<LocalStorageService>().saveData(
          key: 'branches',
          value: tempBranch.businessBranches!.map((e) => e.toJson()).toList(),
        );
      }
    }
    setState(() {});
  }
}
