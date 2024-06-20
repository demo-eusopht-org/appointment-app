import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/Settings/privacy_policy.dart';
import 'package:appointment_management/src/views/User%20Profile/update_consultant_profile.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';
import 'package:appointment_management/src/views/widgets/business_item.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_button.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';
import '../Auth/login.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool switchValue = false;

  User? userData;

  dynamic user, businessId;

  @override
  void initState() {
    super.initState();
    _init();
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
        title: 'User Profile',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: AppColors.primary,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset('assets/images/Vector 1.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset('assets/images/Vector 2.png'),
                      ),
                      Positioned(
                        top: 0,
                        left: 10,
                        bottom: MediaQuery.sizeOf(context).height * 0.003,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 35.sp,
                                        backgroundImage: userData!.imageName !=
                                                null
                                            ? CachedNetworkImageProvider(
                                                '${Constants.businessImageBaseUrl}${userData!.imageName}')
                                            : AssetImage(AppImages.noImage)
                                                as ImageProvider<Object>,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textWidget(
                                      text: '${userData!.name ?? 'No name'}',
                                      fSize: 15.sp,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    if (userData!.email != null)
                                      textWidget(
                                        text: userData!.email.toString(),
                                        fSize: 10.sp,
                                        fWeight: FontWeight.w500,
                                        color: Colors.white,
                                        isUpperCase: false,
                                      ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    final route = CupertinoPageRoute(
                                      builder: (context) =>
                                          UpdateConsultantProfile(
                                              user: userData!),
                                    );

                                    Navigator.push(context, route);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                        textWidget(
                                          text: "Edit",
                                          fWeight: FontWeight.w400,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (userData!.phoneNumber != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                          child: Image.asset(
                            AppImages.phone,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textWidget(
                          text: userData!.phoneNumber.toString(),
                          fSize: 14.0,
                          fWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 10.sp,
                ),
                if (userData!.email != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.email,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textWidget(
                          text: userData!.email!,
                          fWeight: FontWeight.w700,
                          isUpperCase: false,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 10.sp,
                ),
                if (userData!.field != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.build,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textWidget(
                          text: userData!.field!,
                          fWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 10.sp,
                ),
                if (userData!.about != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.work,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: textWidget(
                            text: 'Experience ${userData!.experience!} years',
                            fWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 10.sp,
                ),
                if (userData!.about != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.description,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: textWidget(
                            text: userData!.about!,
                            fWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                            text: "Notifications",
                            fSize: 18.0,
                            fWeight: FontWeight.w700,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Switch.adaptive(
                            activeTrackColor: AppColors.primary,
                            value: switchValue,
                            onChanged: (newValue) {
                              setState(() {
                                switchValue = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: RoundedElevatedButton(
                    onPressed: () async {
                      isAdmin = null;
                      await locator<LocalStorageService>().clearAll();
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (_) => false,
                      );
                    },
                    text: "Sign Out",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _init() async {
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    userData = GetLocalData.getUser();
  }
}
