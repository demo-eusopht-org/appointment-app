import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/email_validator.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/home/home_screen.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/custom_textfield.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import '../../resources/assets.dart';

class AddConsultant extends StatefulWidget {
  const AddConsultant({super.key});

  @override
  State<AddConsultant> createState() => _AddConsultantState();
}

class _AddConsultantState extends State<AddConsultant> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  XFile? _selectedImage;

  bool isLoading = false;

  dynamic user, businessId;

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

  @override
  void initState() {
    _init();
    super.initState();
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
              text: 'Add Consultant',
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
                          // SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
                          textWidget(
                            text: 'Add Photo',
                            fSize: 14,
                            fWeight: FontWeight.w400,
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill name field';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: fieldController,
                            decoration: InputDecoration(labelText: 'Field'),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Field value';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill email address';
                              }
                              return value.isValidEmail()
                                  ? null
                                  : 'Please fill correct email format';
                            },
                            onChanged: (value) {
                              emailController.value = TextEditingValue(
                                  text: value.trim(),
                                  selection: emailController.selection);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            controller: expController,
                            decoration:
                                InputDecoration(labelText: 'Experience'),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Experience field';
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            controller: aboutController,
                            decoration: InputDecoration(labelText: 'About'),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Password field';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            decoration:
                                InputDecoration(labelText: 'Confirm Password'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return 'Please fill Confirm Password field';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
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
                              width: 106,
                              child: RoundedElevatedButton(
                                borderRadius: 6,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (passwordController.text ==
                                        confirmPasswordController.text) {
                                      addConsultant();
                                    } else {
                                      CustomDialogue.message(
                                          context: context,
                                          message:
                                              'Password and confirm password does not matched');
                                    }
                                  }
                                },
                                text: 'Add',
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
        Positioned(
          bottom: 0,
          left: 0,
          child: SafeArea(
            child: Image.asset(
              "assets/images/Vector 8.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addConsultant() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (businessId != null) {
        if (user != null && user['token'] != null) {
          var request =
              http.MultipartRequest('POST', Uri.parse(Constants.addConsultant));
          request.headers['Authorization'] = 'Bearer ${user['token']}';

          request.fields['name'] = nameController.text;
          request.fields['field'] = fieldController.text;
          request.fields['experience'] = expController.text;
          request.fields['about'] = aboutController.text;
          request.fields['user_id'] = user['user']['id'].toString();

          request.fields['business_id'] = businessId.toString();
          request.fields['password'] = passwordController.text;
          request.fields['email'] = emailController.text;

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

          if (res['status'] == 200) {
            CustomDialogue.message(context: context, message: res['message']);
            // await getConsultantData();
            // ignore: use_build_context_synchronously
            await ApiServices.reSaveConsultant(context);

            final route = MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );

            Navigator.pushReplacement(context, route);
          } else {
            if (res.toString().contains('message')) {
              CustomDialogue.message(
                  context: context,
                  message: 'Consultant not created: ${res['message']}');
            } else {
              CustomDialogue.message(
                  context: context,
                  message: 'Consultant not created: ${res['error']}');
            }
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
              'Consultant not created\nPlease check your internet connection');
    } catch (e, stack) {
      CustomDialogue.message(
          context: context,
          message: 'Consultant not created: Please try again');

      log('Error in addConsultant runtimeType: ${e}', stackTrace: stack);
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // Future<void> getConsultantData() async {
  //   log('waiting here');
  //   GetConsultant? tempConsultant = await ApiServices.getConsultant(
  //     context,
  //     Constants.getBusiness + businessId.toString(),
  //     user,
  //   );

  //   if (tempConsultant != null) {
  //     await locator<LocalStorageService>().delete('consultants');
  //     await locator<LocalStorageService>().saveData(
  //       key: 'consultants',
  //       value: tempConsultant.consultants.map((e) => e.toJson()).toList(),
  //     );
  //     log('waiting here done');
  //   }
  //   setState(() {});
  // }

  Future<void> _init() async {
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
  }
}
