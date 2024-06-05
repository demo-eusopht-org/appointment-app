import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
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
import '../../resources/assets.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  XFile? _selectedImage;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

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

  dynamic user;
  dynamic businessId;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
    referenceController.dispose();
    aboutController.dispose();
    occupationController.dispose();
    // selectedConsultantId.dispose();
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
              text: 'Add Customer',
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
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _openImagePicker();
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    height: MediaQuery.of(context).size.width *
                                        0.28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Appcolors.lightTheme.primaryColor,
                                    ),
                                    child: _selectedImage != null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: ClipOval(
                                              child: Image.file(
                                                File(_selectedImage!.path),
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                                // Ensure the image covers the entire space
                                              ),
                                            ),
                                          )
                                        : Image.asset(
                                            AppImages.account,
                                          )
                                    // padding: EdgeInsets.all(
                                    //     MediaQuery.of(context).size.width * 0.1),
                                    ),
                              ),
                              Positioned(
                                right: 5,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 13,
                                  child: Image.asset(
                                    height: 16,
                                    width: 16,
                                    color: Colors.white,
                                    AppImages.camera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          textWidget2(
                            text: 'Add Photo',
                            fSize: 14,
                            fWeight: FontWeight.w400,
                          ),
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
                          CustomTextField(
                            hintText: "Mobile No.",
                            controller: mobileNoController,
                            validatorCondition: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Mobile No field';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hintText: "Email",
                            controller: emailController,
                            validatorCondition: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Email field';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // ValueListenableBuilder(
                          //   valueListenable: selectedConsultantId,
                          //   builder: (context, value, child) {
                          //     return DropdownButton<String?>(
                          //       value: selectedConsultantId.value,
                          //       dropdownColor: AppColors.whiteColor,
                          //       hint: textWidget(text: 'Select consultant'),
                          //       borderRadius: BorderRadius.circular(10),
                          //       isExpanded: true,
                          //       items: consultantsData!.consultants
                          //           .map((Consultant e) =>
                          //               DropdownMenuItem<String?>(
                          //                   value: e.id.toString(),
                          //                   child:
                          //                       textWidget(text: '${e.name}')))
                          //           .toList(),
                          //       onChanged: (String? value) {
                          //         selectedConsultantId.value = value;
                          //       },
                          //     );
                          //   },
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date of birth',
                                    style: MyTextStyles.smallBlacktext.copyWith(
                                        color: AppColors.black.withOpacity(
                                      0.5,
                                    )),
                                  ),
                                  Text(
                                    ' ${selectedDate != null ? utils.pkFormatDate(selectedDate.toString(), 'onlyDate') : 'Select date of birth'}',
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
                          CustomTextField(
                            hintText: "Reference No.",
                            controller: referenceController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hintText: "address",
                            controller: addressController,
                          ),
                          CustomTextField(
                            hintText: "Occupation",
                            controller: occupationController,
                            validatorCondition: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Occupation field';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Builder(builder: (context) {
                            if (isLoading) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: const CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Container(
                              height: 40,
                              child: RoundedElevatedButton(
                                borderRadius: 6,
                                onPressed: () {
                                  // if (selectedConsultantId.value != null) {
                                  if (selectedDate != null) {
                                    if (formKey.currentState!.validate()) {
                                      addCustomer();
                                    }
                                  } else {
                                    CustomDialogue.message(
                                        context: context,
                                        message: 'Please select Date of birth');
                                  }
                                  // }
                                  // else {
                                  //   CustomDialogue.message(
                                  //       context: context,
                                  //       message: 'Please select consultant');
                                  // }
                                },
                                text: 'Create new customer',
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

  Future<void> addCustomer() async {
    setState(() {
      isLoading = true;
    });

    try {
      user = locator<LocalStorageService>().getData(key: 'user');
      businessId = locator<LocalStorageService>().getData(key: 'businessId');

      if (businessId != null) {
        if (user != null && user['token'] != null) {
          log('Constants.addCustomer ${Constants.addCustomer}');
          var request =
              http.MultipartRequest('POST', Uri.parse(Constants.addCustomer));
          request.headers['Authorization'] = 'Bearer ${user['token']}';

          request.fields['name'] = nameController.text;
          request.fields['mobile'] = mobileNoController.text;
          request.fields['email'] = emailController.text;
          request.fields['dob'] =
              utils.pkFormatDate(selectedDate.toString(), 'onlyDate');
          request.fields['refrenceno'] = referenceController.text;
          request.fields['address'] = addressController.text;
          request.fields['occupation'] = occupationController.text;

          request.fields['business_id'] = businessId.toString();
          // request.fields['consultant_id'] =
          //     selectedConsultantId.value.toString();

          // Add image file to the request
          if (_selectedImage != null) {
            request.files.add(await http.MultipartFile.fromPath(
                'images', '${_selectedImage?.path}'));
          } else {
            request.fields['images'] = _selectedImage.toString();
          }

          // Send the request

          var response = await request.send();
          // Convert response bytes to string
          var responseBytes = await response.stream.toBytes();

          var responseBody = utf8.decode(responseBytes);
          final res = jsonDecode(responseBody);

          // Check the response status code
          log('res data ${res}');
          if (res['status'] == 200) {
            CustomDialogue.message(context: context, message: res['message']);

            final route = MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );

            Navigator.pushReplacement(context, route);
          } else {
            CustomDialogue.message(
                context: context,
                message: 'Customer not created: ${res['message']}');
          }
        }
      } else {
        CustomDialogue.message(
            context: context, message: 'Please create your business first');
      }
    } on SocketException catch (e) {
      CustomDialogue.message(
          context: context,
          message:
              'Customer not created\nPlease check your internet connection');
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Customer not created: Please try again');

      log('Error in addCustomer runtimeType: ${e}', stackTrace: stack);
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
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

  DateTime? selectedDate;

  Future<void> _init() async {
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    // await getConsultantData();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.buttonColor,
      ),
    );
  }
}
