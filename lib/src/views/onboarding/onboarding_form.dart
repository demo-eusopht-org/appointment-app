import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/email_validator.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/splash.dart';
import 'package:appointment_management/src/views/widgets/cached_network_image.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../resources/assets.dart';
import '../../resources/textstyle.dart';

class OnboardingPage extends StatefulWidget {
  final bool isUpdate;
  final Business? business;
  const OnboardingPage({
    super.key,
    required this.isUpdate,
    this.business,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  // final TextEditingController feesController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  // final TextEditingController quotationController = TextEditingController();

  // String? selectedLanguage;
  // String? selectedCountryCode;
  String? selectedStartTime;
  String? selectedEndTime;
  XFile? _selectedImage;

  bool isLoading = false;

  Future<void> _openImagePicker() async {
    final imagePicker = ImagePicker();
    final selectedImage = await imagePicker.pickImage(
        source: ImageSource
            .gallery); // You can change ImageSource to camera if you want to capture an image

    if (selectedImage != null) {
      setState(() {
        _selectedImage = selectedImage;
      });
    }
  }

  final formKey = GlobalKey<FormState>();
  final dateTimeKey = GlobalKey<FormState>();
  Business? business;
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
            automaticallyImplyLeading: widget.isUpdate,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: textWidget(
              text: '${(widget.isUpdate) ? 'Update' : 'Create'} your business',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              // Page 1
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openImagePicker();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryTheme,
                          ),
                          child: _selectedImage != null
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
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
                              : widget.isUpdate
                                  ? CircleAvatar(
                                      radius: 35.sp,
                                      backgroundImage:
                                          business!.imageName != null
                                              ? CachedNetworkImageProvider(
                                                  business!.imageName!,
                                                )
                                              : AssetImage(AppImages.noImage)
                                                  as ImageProvider<Object>)
                                  : Image(
                                      image: AssetImage(AppImages.camera),
                                    ),
                        ),
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      textWidget(text: 'Add Photo'),

                      // Form Fields
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
                      TextFormField(
                          controller: professionController,
                          decoration: InputDecoration(labelText: 'Profession')),
                      TextFormField(
                          controller: addressController,
                          decoration:
                              InputDecoration(labelText: 'Complete Address')),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            return value.isValidEmail()
                                ? null
                                : 'Please fill correct email format';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          emailController.value = TextEditingValue(
                              text: value.trim(),
                              selection: emailController.selection);
                        },
                      ),
                      TextFormField(
                          controller: websiteController,
                          decoration: InputDecoration(
                            labelText: 'Website',
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // CountryCodePicker(
                          //   showDropDownButton: true,
                          //   padding: EdgeInsets.zero,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedCountryCode = value.dialCode;
                          //     });
                          //   },
                          //   initialSelection: 'Pakistan',
                          //   favorite: ['+92', 'Pakistan'],
                          // ),
                          Expanded(
                            child: TextFormField(
                              controller: mobileController,
                              decoration: InputDecoration(
                                  hintText: 'Enter phone 0312-----67'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                      // Row(
                      //   children: [
                      //     Text(
                      //       'Language:',
                      //       style: MyTextStyles.normalblacktext,
                      //     ),
                      //     SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.015),
                      //     DropdownButton<String>(
                      //       value: selectedLanguage = "English",
                      //       focusColor: Colors.black,
                      //       dropdownColor: Colors.white,
                      //       items: <String>[
                      //         'English',
                      //         'Spanish',
                      //         'French',
                      //         'German'
                      //       ].map((String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       }).toList(),
                      //       onChanged: (newValue) {
                      //         setState(() {
                      //           selectedLanguage = newValue;
                      //         });
                      //       },
                      //       style: TextStyle(color: Colors.black),
                      //     ),
                      //   ],
                      // ),

                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(2, (int index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            height: MediaQuery.sizeOf(context).height * 0.04,
                            width: MediaQuery.sizeOf(context).width * 0.025,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),

                      // Next Button
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: AppColors.primaryTheme,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Text(
                            'Next',
                            style: MyTextStyles.boldTextWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Page 2
              Form(
                key: dateTimeKey,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: locationController,
                        decoration:
                            const InputDecoration(labelText: 'Location'),
                      ),
                      // TextFormField(
                      //     controller: feesController,
                      //     decoration: InputDecoration(labelText: 'Fees')),
                      TextFormField(
                        controller: noteController,
                        decoration: InputDecoration(
                          labelText: 'Add Note',
                          // filled: true,
                          // fillColor: AppColors.grey.withOpacity(0.5),
                          // border: InputBorder.none,
                        ),
                      ),
                      // TextFormField(
                      //     controller: quotationController,
                      //     decoration:
                      //         InputDecoration(labelText: 'Quotation/Footnote')),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),

                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DateTimePicker(
                                  initialValue: widget.isUpdate
                                      ? selectedStartTime
                                      : TimeOfDay.now().toFormatted12Hours(),
                                  type: DateTimePickerType.time,
                                  firstDate: DateTime.now(),
                                  icon: const Icon(Icons.access_time_filled),
                                  timeLabelText: "Business Start Time",
                                  onChanged: (String? val) => setState(() =>
                                      selectedStartTime =
                                          val!.fromHourMintoFormattedTime()),
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please select business start time';
                                    }
                                    return null;
                                  },
                                  onSaved: (String? val) => setState(() =>
                                      selectedStartTime =
                                          val!.fromHourMintoFormattedTime()),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DateTimePicker(
                                  initialValue: widget.isUpdate
                                      ? selectedEndTime
                                      : TimeOfDay.now().toFormatted12Hours(),
                                  type: DateTimePickerType.time,
                                  firstDate: DateTime.now(),
                                  icon: const Icon(Icons.access_time_filled),
                                  timeLabelText: "Business End Time",
                                  onChanged: (String? val) {
                                    setState(() => selectedEndTime =
                                        val!.fromHourMintoFormattedTime());
                                  },
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please select business end time';
                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) => setState(() =>
                                      selectedEndTime =
                                          val!.fromHourMintoFormattedTime()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),

                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(2, (int index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            height: MediaQuery.sizeOf(context).height * 0.04,
                            width: MediaQuery.sizeOf(context).width * 0.025,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),

                      // Done Button

                      Builder(
                        builder: (context) {
                          if (isLoading) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          }
                          return Container(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: AppColors.primaryTheme),
                              onPressed: () {
                                if (dateTimeKey.currentState!.validate()) {
                                  onBoarding();
                                }
                              },
                              child: Text(
                                widget.isUpdate ? 'Update' : 'Done',
                                style: MyTextStyles.boldTextWhite,
                              ),
                            ),
                          );
                        },
                      ),
                      // BlocBuilder<OnBoardingBloc, OnBoardingStates>(
                      //     bloc: BlocProvider.of<OnBoardingBloc>(context),
                      //     builder: (context, state) {
                      //       if (state is OnBoardingLoadingState) {
                      //         return const CircularProgressIndicator();
                      //       }
                      //       return Container(
                      //         alignment: Alignment.bottomRight,
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(8.0),
                      //               ),
                      //               backgroundColor:
                      //                   Appcolors.lightTheme.primaryColor),
                      //           onPressed: () {
                      //             print('formKey2 ${dateTimeKey.currentState}');
                      //             if (dateTimeKey.currentState!.validate()) {
                      //               onBoarding();
                      //             }

                      //             // Navigator.push(
                      //             //   context,
                      //             //   CupertinoPageRoute(
                      //             //     builder: (context) => HomeScreen(),
                      //             //   ),
                      //             // );
                      //           },
                      //           child: Text(
                      //             'Done',
                      //             style: MyTextStyles.boldTextWhite,
                      //           ),
                      //         ),
                      //       );
                      //     }),
                    ],
                  ),
                ),
              )
            ],
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
          left: 0,
          bottom: 0,
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

  Future<void> onBoarding() async {
    setState(() {
      isLoading = true;
    });

    try {
      String url = widget.isUpdate
          ? Constants.onBoardingUpdate
          : Constants.onBoardingSignUp;
      final user = locator<LocalStorageService>().getData(key: 'user');
      final businessId =
          locator<LocalStorageService>().getData(key: 'businessId');

      if (user != null && user['token'] != null) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(url),
        );
        request.headers['Authorization'] = 'Bearer ${user['token']}';

        if (widget.isUpdate) {
          request.fields['business_id'] = businessId.toString();
          request.fields['created_at'] = business!.createdAt!.toString();
          request.fields['updated_at'] =
              DateTime.now().copyWith(isUtc: true).toString();
        }

        request.fields['name'] = nameController.text;
        request.fields['profession'] = professionController.text;
        request.fields['complete_address'] = addressController.text;
        request.fields['phone_number'] = mobileController.text;
        request.fields['language'] = 'English';
        request.fields['email'] = emailController.text;
        request.fields['website'] = websiteController.text;
        request.fields['location'] = locationController.text;
        // request.fields['fees'] = feesController.text;
        request.fields['whatsapp_note'] = noteController.text;
        // request.fields['footnote'] = quotationController.text;
        request.fields['user_id'] = user['user']['id'].toString();
        request.fields['start_time'] = selectedStartTime.toString();
        request.fields['end_time'] = selectedEndTime.toString();

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

        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);

          if (!widget.isUpdate) {
            await locator<LocalStorageService>().saveData(
              key: 'businessId',
              value: res['business'][0]['id'],
            );
          }

          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            CupertinoPageRoute(
              builder: (context) => widget.isUpdate
                  ? const HomeScreen()
                  : const SplashScreen(
                      fromLogin: true,
                    ),
            ),
          );
        } else {
          CustomDialogue.message(
              context: context,
              message:
                  'Business not ${widget.isUpdate ? 'updated' : 'created'}: ${res['message']}');
        }
      }
    } on SocketException {
      CustomDialogue.message(
          context: context,
          message:
              'Business not ${widget.isUpdate ? 'updated' : 'created'}\nPlease check your internet connection');
    } catch (e, stack) {
      log('Error in ${widget.isUpdate ? 'updated' : 'created'}Business api ${e}',
          stackTrace: stack);
      CustomDialogue.message(
          context: context,
          message:
              'Business not ${widget.isUpdate ? 'updated' : 'created'}: Please try again');

      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _init() {
    if (widget.isUpdate) {
      setBusinessFields();
    }
  }

  void setBusinessFields() {
    business = widget.business;
    nameController.text = business!.name.toString();
    if (business!.profession != null) {
      professionController.text = business!.profession!;
    }
    if (business!.completeAddress != null) {
      addressController.text = business!.completeAddress!;
    }
    if (business!.email != null) {
      emailController.text = business!.email!;
    }
    if (business!.website != null) {
      websiteController.text = business!.website!;
    }
    if (business!.phoneNumber != null) {
      mobileController.text = business!.phoneNumber!;
    }
    if (business!.location != null) {
      locationController.text = business!.location!;
    }
    if (business!.fees != null) {
      // feesController.text = business!.fees.toString();
    }
    if (business!.whatsappNote != null) {
      noteController.text = business!.whatsappNote!;
    }
    if (business!.footNote != null) {
      // quotationController.text = business!.footNote!;
    }

    if (business!.startTime != null) {
      selectedStartTime = business!.startTime!.fromHourMintoFormattedTime();
    }
    if (business!.endTime != null) {
      selectedEndTime = business!.endTime!.fromHourMintoFormattedTime();
    }

    // "updated_at": "2024-05-03T06:43:27.000Z",
  }

  // Future<void> onBoarding() async {
  //   BlocProvider.of<OnBoardingBloc>(context).add(
  //     CreateOnBoardEvent(
  //       name: nameController.text,
  //     ),
  //   );
  // }
}
