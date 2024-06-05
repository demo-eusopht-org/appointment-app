import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:appointment_management/src/utils/date_time_utils.dart';

class CreateBranch extends StatefulWidget {
  const CreateBranch({super.key});

  @override
  State<CreateBranch> createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  XFile? _selectedImage;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  Api? api;

  // bool findingConsultant = true;
  // GetConsultant? consultantsData;
  // ValueNotifier<String?> selectedConsultantId = ValueNotifier<String?>(null);

  Future<void> _openImagePicker() async {
    final imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = selectedImage;
      });
    }
  }

  dynamic businessId;

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
              text: 'Create Branch',
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
                          CustomTextField(
                            hintText: "Name",
                            controller: nameController,
                            validatorCondition: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Name field';
                              }
                              return null;
                            },
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
                                    // ' ${selectedStartTime != null ? utils.pkFormatDate(selectedStartTime.toString(), 'onlyDate') : 'Select Branch Start time'}',
                                    selectedStartTime != null
                                        ? selectedStartTime!.toFormattedTime()
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
                                    // ' ${selectedStartTime != null ? utils.pkFormatDate(selectedEndTime.toString(), 'onlyDate') : 'Select Branch End time'}',
                                    selectedEndTime != null
                                        ? '${selectedEndTime!.toFormattedTime()}'
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
                          CustomTextField(
                            hintText: "address",
                            controller: addressController,
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

                                  // }
                                  // else {
                                  //   CustomDialogue.message(
                                  //       context: context,
                                  //       message: 'Please select consultant');
                                  // }
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
          "start_time": selectedStartTime!.toFormattedTime(),
          "end_time": selectedEndTime!.toFormattedTime(),
          "address": addressController.text,
        },
      );
      log('res service ${res}');
      log('res service ${res['status']}');

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
      log('Something went wrong in create branch api $e');
      CustomDialogue.message(
          context: context, message: 'Branch not created $e');
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
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    // await getConsultantData();
  }
}
