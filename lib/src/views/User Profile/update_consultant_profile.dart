import 'dart:developer';
import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/Home/home_screen.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateConsultantProfile extends StatefulWidget {
  final User user;
  const UpdateConsultantProfile({required this.user});
  @override
  // ignore: library_private_types_in_public_api
  _UpdateConsultantProfilePageS createState() =>
      _UpdateConsultantProfilePageS();
}

class _UpdateConsultantProfilePageS extends State<UpdateConsultantProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    User user = widget.user;
    if (user.name != null) {
      nameController.text = user.name!;
    }
    if (user.field != null) {
      fieldController.text = user.field.toString();
    }
    if (user.about != null) {
      aboutController.text = user.about.toString();
    }

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
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Update ${isAdmin! ? 'Consultant' : 'Profile'}',
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
                  controller: fieldController,
                  decoration: const InputDecoration(labelText: 'Field'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.sp),
                TextFormField(
                  controller: aboutController,
                  decoration: const InputDecoration(labelText: 'About'),
                  maxLines: 3,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill about field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.sp),
                isLoading
                    ? const Loader()
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

      dynamic res = await api.updateConsultantProfile(
        {
          "id": widget.user.id,
          "name": nameController.text,
          "field": fieldController.text,
          "about": aboutController.text
        },
      );

      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously

        CustomDialogue.message(context: context, message: res['message']);

        if (!isAdmin!) {
          utils.updatingUser(
            updateProfile: true,
            userData: widget.user,
            name: nameController.text,
            about: aboutController.text,
            field: fieldController.text,
          );
        } else {
          // ignore: use_build_context_synchronously
          await ApiServices.reSaveConsultant(context);
        }
        final route = CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
        Navigator.push(context, route);
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
      log('Something went wrong in Update User Profile api $e');
      CustomDialogue.message(
          context: context, message: 'User Profile not updated $e');
    }
  }
}
