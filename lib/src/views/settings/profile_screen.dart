import 'dart:developer';
import 'dart:io';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/Settings/privacy_policy.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool switchValue = false;

  User? userData;
  bool isLoading = false;

  dynamic user, businessId;

  List<Business>? businessData;
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
        title: 'Business Profile',
      ),
      body: isLoading
          ? const Loader()
          : businessData == null
              ? textWidget(text: 'No business created')
              : Stack(
                  children: [
                    for (int i = 0; i < businessData!.length; i++)
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
                                    child: Image.asset(
                                        'assets/images/Vector 1.png'),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Image.asset(
                                        'assets/images/Vector 2.png'),
                                  ),
                                  if (businessData![i].name != null)
                                    Positioned(
                                      top: 0,
                                      left: 10,
                                      bottom:
                                          MediaQuery.sizeOf(context).height *
                                              0.003,
                                      right: 0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: CircleAvatar(
                                                      radius: 35.sp,
                                                      backgroundImage: businessData![
                                                                      i]
                                                                  .imagename !=
                                                              null
                                                          ? CachedNetworkImageProvider(
                                                              '${Constants.businessImageBaseUrl}${businessData![i].imagename}')
                                                          : AssetImage(AppImages
                                                                  .noImage)
                                                              as ImageProvider<
                                                                  Object>,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  textWidget(
                                                    text: businessData![i]
                                                        .name
                                                        .toString(),
                                                    fSize: 15.sp,
                                                    fWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                  ),
                                                  if (businessData![i].email !=
                                                      null)
                                                    textWidget(
                                                      text: businessData![i]
                                                          .email
                                                          .toString(),
                                                      fSize: 10.sp,
                                                      fWeight: FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
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
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BusinessItem(
                              name: '${businessData![i].name}',
                              imagePath: AppImages.hospital,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BusinessItem(
                              name: businessData![i].completeAddress.toString(),
                              imagePath: AppImages.location,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (businessData![i].phoneNumber != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.primary,
                                      child: Image.asset(
                                        AppImages.phone,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    textWidget(
                                      text: businessData![i]
                                          .phoneNumber
                                          .toString(),
                                      fSize: 14.0,
                                      fWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            if (businessData![i].email != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.primary,
                                      child: Image.asset(
                                        AppImages.email,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    textWidget(
                                      text: userData!.email,
                                      fWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            if (businessData![i].website != null)
                              InkWell(
                                onTap: () {
                                  _launchUrl(
                                      '${businessData![i].website.toString()}');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.primary,
                                        child: Image.asset(
                                          AppImages.earth,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      if (businessData![i].website != null)
                                        textWidget(
                                          text: '${businessData![i].website}',
                                          fSize: 14.0,
                                          fWeight: FontWeight.w700,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                        text: "Notifications",
                                        fSize: 18.0,
                                        fWeight: FontWeight.w700,
                                      ),
                                      SizedBox(
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => PrivacyPolicy(),
                                        ),
                                      );
                                    },
                                    child: textWidget(
                                      text: "Privacy Policy",
                                      fSize: 18.0,
                                      fWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: RoundedElevatedButton(
                                onPressed: () async {
                                  await locator<LocalStorageService>()
                                      .clearAll();
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

  Future<void> _launchUrl(String? url) async {
    print('LinK:$url');
    if (url != null) {
      final uri = url.contains('https') ? Uri.parse(url) : Uri.https(url);
      print('check ${uri.toString()}');
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  Future<void> getBusinessData() async {
    GetBusinessData? tempBusiness = await ApiServices.getBusinessData(
      context,
      Constants.getBusinessData + userData!.id.toString(),
      user,
    );

    if (tempBusiness != null) {
      if (tempBusiness.business!.isNotEmpty) {
        businessData = tempBusiness.business;
      }
    }
    setState(() {});
  }

  Future<void> _init() async {
    setState(() {
      isLoading = true;
    });
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    userData = GetLocalData.getUser();
    await getBusinessData();
    setState(() {
      isLoading = false;
    });
  }
}
