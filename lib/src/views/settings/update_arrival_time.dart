import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateArrivalTimePage extends StatefulWidget {
  const UpdateArrivalTimePage({
    super.key,
  });

  @override
  State<UpdateArrivalTimePage> createState() => _UpdateArrivalTimePage();
}

class _UpdateArrivalTimePage extends State<UpdateArrivalTimePage> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Api? api;

  List<Business> business = [];

  final arrivalTime = TextEditingController();

  @override
  void initState() {
    business = GetLocalData.getBusiness();
    if (business.isNotEmpty) {
      arrivalTime.text = business.first.arrivalTime!.split(' ').first;
    } else {
      arrivalTime.text = '';
    }

    api = Api(
      dio,
      baseUrl: Constants.baseUrl,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Update Arrival Time',
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10.sp,
              ),
              TextField(
                controller: arrivalTime,
                decoration: InputDecoration(
                  hintText: 'Enter arrival time',
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  suffix: textWidget(text: 'minutes'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10.sp,
              ),
              Builder(builder: (context) {
                if (isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SizedBox(
                  height: MediaQuery.sizeOf(context).width * 0.1,
                  width: MediaQuery.sizeOf(context).width,
                  child: RoundedElevatedButton(
                    borderRadius: 6,
                    onPressed: () {
                      updateArrivalTime();
                    },
                    text: 'Update',
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateArrivalTime() async {
    try {
      setState(() {
        isLoading = true;
      });

      dynamic res = await api!.updateArrivalTime(
        {
          "business_id": business.first.id,
          "arrival_time": "${arrivalTime.text.trim()} minutes",
        },
      );

      if (res['status'] == 200) {
        CustomDialogue.message(context: context, message: res['message']);

        await getBusinessData();
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        if (res.toString().contains('message')) {
          CustomDialogue.message(context: context, message: res['message']);
        } else {
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
    } catch (e) {
      log('Something went wrong in updating arrival time api $e');
      CustomDialogue.message(
          // ignore: use_build_context_synchronously
          context: context,
          message: 'Something went wrong in updating arrival time: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getBusinessData() async {
    final user = locator<LocalStorageService>().getData(key: 'user');

    int businessId = isAdmin! ? user['user']['id'] : user['business_owner_id'];

    GetBusinessData? tempBusiness = await ApiServices.getBusinessData(
      context,
      Constants.getBusinessData + businessId.toString(),
      user,
    );

    if (tempBusiness != null) {
      if (tempBusiness.business!.isNotEmpty) {
        await locator<LocalStorageService>().delete('businessData');

        await locator<LocalStorageService>().saveData(
          key: 'businessData',
          value: tempBusiness.business!.map((e) => e.toJson()).toList(),
        );
      }
    }
  }
}
