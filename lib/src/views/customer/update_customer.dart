import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateCustomerProfile extends StatefulWidget {
  final Customer customer;
  const UpdateCustomerProfile({required this.customer});
  @override
  // ignore: library_private_types_in_public_api
  _UpdateCustomerProfileState createState() => _UpdateCustomerProfileState();
}

class _UpdateCustomerProfileState extends State<UpdateCustomerProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    Customer customer = widget.customer;
    nameController.text = customer.name ?? '';
    mobileController.text = customer.mobile ?? '';
    occupationController.text = customer.occupation ?? '';
    addressController.text = customer.address ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: customAppBar(
        context: context,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: 'Update Customer',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill name field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.sp),
                TextFormField(
                  controller: mobileController,
                  decoration: const InputDecoration(labelText: 'Mobile'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill mobile field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.sp),
                TextFormField(
                  controller: occupationController,
                  decoration: const InputDecoration(labelText: 'Occupation'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add occupation';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.sp),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill address field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.sp),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updateProfile();
                          }
                        },
                        child: textWidget(
                          text: 'Update Profile',
                          color: AppColors.white,
                          fWeight: FontWeight.w600,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      Api api = Api(
        dio,
        baseUrl: Constants.baseUrl,
      );

      dynamic res = await api.updateCustomerProfile(
        {
          "id": widget.customer.id,
          "name": nameController.text,
          "mobile": mobileController.text,
          "occupation": occupationController.text,
          "address": addressController.text,
        },
      );

      if (res['status'] == 200) {
        CustomDialogue.message(context: context, message: res['message']);
        await ApiServices.reSaveCustomer(context);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        CustomDialogue.message(
          context: context,
          message: res['message'] ?? res['error'],
        );
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Something went wrong in Update User Profile api $e');
      CustomDialogue.message(
          context: context, message: 'User Profile not updated $e');
    }
  }
}
