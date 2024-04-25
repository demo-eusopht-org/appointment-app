import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/custom_dropdown.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/app_colors.dart';
import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/custom_drawer.dart';
import '../thankyou/thankyou_screen.dart';

class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking({super.key});

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  List<String> consultantOptions = [
    'Dr. Michael Pole ',
    'Consultant 2',
    'Consultant 3'
  ];
  List<String> procedures = [
    'Check Up ',
    'Treatment',
    'Guidance',
  ];

  DateTime? selectedDate;
  String? selectedStartTime;
  TimeOfDay? selectedTime;
  String? selectedConsultant;
  String? selectProcedure;
  bool isChecked = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        title: 'Appointment Booking',
        leadingIcon: Icon(
          Icons.arrow_back_outlined,
        ),
        leadingIconOnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        action: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  textWidget2(
                    text: "Patient",
                    fSize: 15.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 42,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, left: 12),
                          hintText: 'Search By Name or Phone No.',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColors.ratingbarColor,
                          filled: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(38),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  textWidget2(
                    text: "Date",
                    fSize: 15.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.07,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      height: 36,
                      width: MediaQuery.sizeOf(context).width * 0.35,
                      decoration: BoxDecoration(
                        color: AppColors.ratingbarColor,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textWidget(
                            text: selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Select Date',
                            fSize: 10.0,
                            fWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                          ),
                          Icon(
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
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  textWidget2(
                    text: "Start Time",
                    fSize: 15.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Container(
                      height: 36,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.ratingbarColor,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textWidget(
                              text: selectedTime != null
                                  ? '${selectedTime!.format(context)}'
                                  : 'Select Time',
                              fSize: 10.0,
                              fWeight: FontWeight.w400,
                              color: Colors.grey.shade700,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  textWidget2(
                    text: "Consultant",
                    fSize: 15.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  CustomDropdownFormField(
                    items: consultantOptions,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedConsultant = newValue;
                      });
                    },
                    dropdownColor: AppColors.ratingbarColor,
                    hintText: 'Dr XYZ',
                    value: selectedConsultant,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  textWidget2(
                    text: "Procedures",
                    fSize: 15.0,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  CustomDropdownFormField(
                    items: procedures,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectProcedure = newValue;
                      });
                    },
                    dropdownColor: AppColors.ratingbarColor,
                    hintText: 'Select Procedures',
                    value: selectProcedure,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  textWidget2(
                    text: "Share On WhatsApp",
                    fSize: 15.0,
                    fWeight: FontWeight.w500,
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    visualDensity: VisualDensity.compact,
                    activeColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              Container(
                height: 42,
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: RoundedElevatedButton(
                  borderRadius: 36,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ThankYouScreen(),
                      ),
                    );
                  },
                  text: "Add Appoitment",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
