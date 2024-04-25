import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/assets.dart';
import '../../resources/textstyle.dart';
import '../home/home_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

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
  final TextEditingController feesController = TextEditingController();
  final TextEditingController whatsappNoteController = TextEditingController();
  final TextEditingController quotationController = TextEditingController();

  String? selectedLanguage;
  String? selectedCountryCode;
  String? selectedStartTime;
  String? selectedEndTime;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: textWidget(
              text: 'Onboarding Form',
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
              SingleChildScrollView(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // Account Icon in Circle
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Appcolors.lightTheme.primaryColor,
                        ),
                        child: Image(
                          image: AssetImage(AppImages.camera),
                        ),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.1),
                      ),
                    ),

                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),

                    Text('Add Photo'),

                    // Form Fields
                    TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name')),
                    TextFormField(
                        controller: professionController,
                        decoration: InputDecoration(labelText: 'Profession')),
                    TextFormField(
                        controller: addressController,
                        decoration:
                            InputDecoration(labelText: 'Complete Address')),
                    TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email')),
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
                          child: TextFormField(
                              controller: mobileController,
                              decoration:
                                  InputDecoration(hintText: 'Mobile No.')),
                        ),
                      ],
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                    Row(
                      children: [
                        Text(
                          'Language:',
                          style: MyTextStyles.normalblacktext,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.015),
                        DropdownButton<String>(
                          value: selectedLanguage = "English",
                          focusColor: Colors.black,
                          dropdownColor: Colors.white,
                          items: <String>[
                            'English',
                            'Spanish',
                            'French',
                            'German'
                          ].map((String value) {
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
                            backgroundColor: Appcolors.lightTheme.primaryColor),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
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

              // Page 2
              SingleChildScrollView(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // Form Fields
                    TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(labelText: 'Location')),
                    TextFormField(
                        controller: feesController,
                        decoration: InputDecoration(labelText: 'Fees')),
                    TextFormField(
                        controller: whatsappNoteController,
                        decoration:
                            InputDecoration(labelText: 'Whatsapp Note')),
                    TextFormField(
                        controller: quotationController,
                        decoration:
                            InputDecoration(labelText: 'Quotation/Footnote')),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Appointment Timings: Default',
                          textAlign: TextAlign.left,
                        )),

                    Row(
                      children: [
                        Expanded(
                          child: DateTimePicker(
                            type: DateTimePickerType.time,
                            icon: Icon(Icons.access_time),
                            timeLabelText: "Start Time",
                            onChanged: (val) =>
                                setState(() => selectedStartTime = val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) =>
                                setState(() => selectedStartTime = val),
                          ),
                        ),
                        Expanded(
                          child: DateTimePicker(
                            type: DateTimePickerType.time,
                            icon: Icon(Icons.access_time),
                            timeLabelText: "End Time",
                            onChanged: (val) =>
                                setState(() => selectedEndTime = val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) =>
                                setState(() => selectedEndTime = val),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

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

                    // Done Button
                    Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Appcolors.lightTheme.primaryColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Done',
                          style: MyTextStyles.boldTextWhite,
                        ),
                      ),
                    ),
                  ],
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
}
