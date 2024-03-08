import 'package:appointment_management/src/resources/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/theme/light/light_theme.dart' as Appcolors;
import 'package:appointment_management/src/resources/assets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
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
  final TextEditingController feesController = TextEditingController();
  final TextEditingController whatsappNoteController = TextEditingController();
  final TextEditingController quotationController = TextEditingController();


  String? selectedLanguage;
  String? selectedCountryCode;
  String? selectedStartTime;
  String? selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: SizedBox.expand(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.rightvectordesign),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                // Page 1
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                        // Title
                        Container(
                          child: Text(
                            'Onboarding Form',
                            style: MyTextStyles.onboardingheading,
                          ),
                          color: Color(0xF0EFEF),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                        // Account Icon in Circle
                        InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Appcolors.lightTheme.primaryColor,
                            ),
                            child: Image(image: AssetImage(AppImages.camera),



                      ),




                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.015),


                        Text('Add Photo'),

                        // Form Fields
                        TextFormField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
                        TextFormField(controller: professionController, decoration: InputDecoration(labelText: 'Profession')),
                        TextFormField(controller: addressController, decoration: InputDecoration(labelText: 'Complete Address')),
                        TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
                        TextFormField(controller: websiteController, decoration: InputDecoration(labelText: 'Website')),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CountryCodePicker(
                              showDropDownButton: true,

                              padding: EdgeInsets.zero,

                              onChanged: (value) {
                                setState(() {
                                  selectedCountryCode = value.dialCode;
                                });
                              },
                              initialSelection: 'Pakistan',
                              favorite: ['+92', 'Pakistan'],
                            ),
                            Expanded(
                              child: TextFormField(controller: mobileController, decoration: InputDecoration(hintText: 'Mobile No.')),
                            ),
                          ],
                        ),
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                        Row(
                          children: [
                            Text('Language:', style: MyTextStyles.normalblacktext,),
                             SizedBox(width: MediaQuery.of(context).size.width * 0.015),

                            DropdownButton<String>(
                              value: selectedLanguage = "English",
                              focusColor: Colors.black,
                              items: <String>['English', 'Spanish', 'French', 'German'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedLanguage = newValue;
                                });
                              },
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),




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
                                color: _currentPage == index ? Colors.blue : Colors.grey,
                              ),
                            );
                          }),
                        ),

                        // Next Button
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                           style:  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),), backgroundColor: Appcolors.lightTheme.primaryColor),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Text('Next', style: MyTextStyles.boldTextWhite,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                // Page 2
    Expanded(
    child: SingleChildScrollView(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      Container(
        child: Text(
          'Onboarding Form',
          style: MyTextStyles.onboardingheading,
        ),
        color: Color(0xF0EFEF),
      ),

    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

    // Account Icon in Circle


                      // Form Fields
                      TextFormField(controller: locationController, decoration: InputDecoration(labelText: 'Location')),
                      TextFormField(controller: feesController, decoration: InputDecoration(labelText: 'Fees')),
                      TextFormField(controller: whatsappNoteController, decoration: InputDecoration(labelText: 'Whatsapp Note')),
                      TextFormField(controller: quotationController, decoration: InputDecoration(labelText: 'Quotation/Footnote')),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),

      Container( alignment: Alignment.centerLeft,child: Text('Appointment Timings: Default', textAlign: TextAlign.left,)),


                      Row(
                        children: [
                          Expanded(
                            child: DateTimePicker(
                              type: DateTimePickerType.time,
                              icon: Icon(Icons.access_time),
                              timeLabelText: "Start Time",
                              onChanged: (val) => setState(() => selectedStartTime = val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => setState(() => selectedStartTime = val),
                            ),
                          ),
                          Expanded(
                            child: DateTimePicker(
                              type: DateTimePickerType.time,
                              icon: Icon(Icons.access_time),
                              timeLabelText: "End Time",
                              onChanged: (val) => setState(() => selectedEndTime = val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => setState(() => selectedEndTime = val),
                            ),
                          ),
                        ],
                      ),

      SizedBox(height: MediaQuery.of(context).size.height * 0.23),


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
                              color: _currentPage == index ? Colors.blue : Colors.grey,
                            ),
                          );
                        }),
                      ),

                      // Done Button
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),backgroundColor: Appcolors.lightTheme.primaryColor),
                          onPressed: () {
                            // Implement your done logic here
                          },
                          child: Text('Done', style: MyTextStyles.boldTextWhite,),
                        ),
                      ),
                    ],
                  ),
                ),
    )],
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter_screenutil/flutter_screenutil.dart';
  // import 'package:get/get.dart';
  // import 'package:appointment_management/src/views/auth/widgets/custom_textfield.dart';
  // import 'package:appointment_management/src/resources/textstyle.dart';
  // import 'package:appointment_management/theme/light/light_theme.dart' as Appcolors;
  // import 'package:appointment_management/src/resources/assets.dart';
  // import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';
  // import 'package:country_code_picker/country_code_picker.dart';
  // import 'package:date_time_picker/date_time_picker.dart';
  //
  // class OnboardingPage extends StatefulWidget {
  //   @override
  //   _OnboardingPageState createState() => _OnboardingPageState();
  // }
  //
  // class _OnboardingPageState extends State<OnboardingPage> {
  //   final PageController _pageController = PageController();
  //   int _currentPage = 0;
  //
  //   final TextEditingController nameController = TextEditingController();
  //   final TextEditingController professionController = TextEditingController();
  //   final TextEditingController addressController = TextEditingController();
  //   final TextEditingController emailController = TextEditingController();
  //   final TextEditingController websiteController = TextEditingController();
  //   final TextEditingController mobileController = TextEditingController();
  //   final TextEditingController locationController = TextEditingController();
  //   final TextEditingController feesController = TextEditingController();
  //   final TextEditingController whatsappNoteController = TextEditingController();
  //   final TextEditingController quotationController = TextEditingController();
  //
  //   String? selectedLanguage;
  //   String? selectedCountryCode;
  //   String? selectedStartTime;
  //   String? selectedEndTime;
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       body: Stack(
  //         children: [
  //           // Background Image
  //           Positioned.fill(
  //             child: SizedBox.expand(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 height: MediaQuery.of(context).size.height,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     image: AssetImage(AppImages.rightvectordesign),
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //
  //           // Content
  //           Positioned.fill(
  //             child: PageView(
  //               controller: _pageController,
  //               onPageChanged: (int page) {
  //                 setState(() {
  //                   _currentPage = page;
  //                 });
  //               },
  //               children: [
  //                 // Page 1
  //                 SingleChildScrollView(
  //                   padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       SizedBox(height: MediaQuery.of(context).size.height * 0.1),
  //
  //                       // Title
  //                       Text(
  //                         'Onboarding Form',
  //                         style: MyTextStyles.boldtitleblack,
  //                       ),
  //                       SizedBox(height: MediaQuery.of(context).size.height * 0.0001),
  //
  //                       // Account Icon in Circle
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: Appcolors.lightTheme.primaryColor,
  //                         ),
  //                         child: Stack(
  //                           alignment: Alignment.bottomRight,
  //                           children: [
  //                             Image(image: AssetImage(AppImages.account),
  //                               width: MediaQuery.of(context).size.width * 0.2,
  //                               height: MediaQuery.of(context).size.height * 0.2,),
  //                             IconButton(
  //                               icon: Icon(Icons.camera_alt),
  //                               onPressed: () {
  //                                 // Implement your camera logic here
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
  //                       ),
  //                       Text('Add Photo'),
  //
  //                       // Form Fields
  //                       CustomTextField(controller: nameController, hintText: 'Name', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: professionController, hintText: 'Profession', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: addressController, hintText: 'Complete Address', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: emailController, hintText: 'Email', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: websiteController, hintText: 'Website', textStyle: MyTextStyles.formtext,),
  //                       Row(
  //                         children: [
  //                           CountryCodePicker(
  //                             onChanged: (value) {
  //                               selectedCountryCode = value.dialCode ?? '';
  //                             },
  //                             initialSelection: 'US',
  //                             favorite: ['+1','US'],
  //                           ),
  //                           CustomTextField(controller: mobileController, hintText: 'Mobile No.', textStyle: MyTextStyles.formtext,),
  //                         ],
  //                       ),
  //                       Text('Language:'),
  //                       DropdownButton<String>(
  //                         value: selectedLanguage,
  //                         items: <String>['English', 'Spanish', 'French', 'German'].map((String value) {
  //                           return DropdownMenuItem<String>(
  //                             value: value,
  //                             child: Text(value),
  //                           );
  //                         }).toList(),
  //                         onChanged: (newValue) {
  //                           setState(() {
  //                             selectedLanguage = newValue;
  //                           });
  //                         },
  //                       ),
  //                       // Add more form fields as per your requirements
  //
  //                       // Page Indicator
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: List<Widget>.generate(2, (int index) {
  //                           return AnimatedContainer(
  //                             duration: Duration(milliseconds: 300),
  //                             margin: EdgeInsets.symmetric(horizontal: 5.0),
  //                             height: 10.0,
  //                             width: 10.0,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: _currentPage == index ? Colors.blue : Colors.grey,
  //                             ),
  //                           );
  //                         }),
  //                       ),
  //
  //                       // Next Button
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           _pageController.nextPage(
  //                             duration: Duration(milliseconds: 500),
  //                             curve: Curves.ease,
  //                           );
  //                         },
  //                         child: Text('Next'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // Page 2
  //                 SingleChildScrollView(
  //                   padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       SizedBox(height: MediaQuery.of(context).size.height * 0.1),
  //
  //                       // Title
  //                       Text(
  //                         'Onboarding Form',
  //                         style: MyTextStyles.boldtitleblack,
  //                       ),
  //                       SizedBox(height: MediaQuery.of(context).size.height * 0.0001),
  //
  //                       // Account Icon in Circle
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: Appcolors.lightTheme.primaryColor,
  //                         ),
  //                         child: Stack(
  //                           alignment: Alignment.bottomRight,
  //                           children: [
  //                             Image(image: AssetImage(AppImages.account),
  //                               width: MediaQuery.of(context).size.width * 0.2,
  //                               height: MediaQuery.of(context).size.height * 0.2,),
  //                             IconButton(
  //                               icon: Icon(Icons.camera_alt),
  //                               onPressed: () {
  //                                 // Implement your camera logic here
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
  //                       ),
  //                       Text('Add Photo'),
  //
  //                       // Form Fields
  //                       CustomTextField(controller: locationController, hintText: 'Location', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: feesController, hintText: 'Fees', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: whatsappNoteController, hintText: 'Whatsapp Note', textStyle: MyTextStyles.formtext,),
  //                       CustomTextField(controller: quotationController, hintText: 'Quotation/Footnote', textStyle: MyTextStyles.formtext,),
  //                       Text('Appointment Timings:'),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: DateTimePicker(
  //                               type: DateTimePickerType.time,
  //                               icon: Icon(Icons.access_time),
  //                               timeLabelText: "Start Time",
  //                               onChanged: (val) => setState(() => selectedStartTime = val),
  //                               validator: (val) {
  //                                 print(val);
  //                                 return null;
  //                               },
  //                               onSaved: (val) => setState(() => selectedStartTime = val),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: DateTimePicker(
  //                               type: DateTimePickerType.time,
  //                               icon: Icon(Icons.access_time),
  //                               timeLabelText: "End Time",
  //                               onChanged: (val) => setState(() => selectedEndTime = val),
  //                               validator: (val) {
  //                                 print(val);
  //                                 return null;
  //                               },
  //                               onSaved: (val) => setState(() => selectedEndTime = val),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       // Add more form fields as per your requirements
  //
  //                       // Page Indicator
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: List<Widget>.generate(2, (int index) {
  //                           return AnimatedContainer(
  //                             duration: Duration(milliseconds: 300),
  //                             margin: EdgeInsets.symmetric(horizontal: 5.0),
  //                             height: 10.0,
  //                             width: 10.0,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: _currentPage == index ? Colors.blue : Colors.grey,
  //                             ),
  //                           );
  //                         }),
  //                       ),
  //
  //                       // Done Button
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           // Implement your done logic here
  //                         },
  //                         child: Text('Done'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
