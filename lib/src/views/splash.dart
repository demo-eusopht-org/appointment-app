import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/assets.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/enums.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/Auth/login.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/home/home_screen.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  final bool? fromLogin;
  const SplashScreen({
    Key? key,
    this.fromLogin,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  dynamic businessId, user;

  User? userData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  void _navigateToNextScreen() {
    if (user != null && user['token'] != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.fromLogin != null && widget.fromLogin!
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                    text: 'Please wait while your app is being configured.'),
                SizedBox(
                  height: 10.sp,
                ),
                const Loader(),
              ],
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _init() async {
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    user = locator<LocalStorageService>().getData(key: 'user');
    log('user ${user}');
    log('businessId ${businessId}');

    if (user != null) {
      userData = GetLocalData.getUser();
      utils.setUserRole(userData!);

      await getCustomerData();
      await getBusinessBranch();
      await getConsultantData();
      await getBusinessData();
      await getServices();
    }

    _navigateToNextScreen();
  }

  Future<void> getServices() async {
    try {
      final res = await ApiServices.getServices(
        context,
        Constants.getService + businessId.toString(),
        user,
      );
      if (res != null) {
        if (res.services!.isNotEmpty) {
          await locator<LocalStorageService>().saveData(
            key: 'services',
            value: res.services!.map((e) => e.toJson()).toList(),
          );
        }
      }
    } catch (e) {
      log('Something went wrong in getServices Api $e');
    }
  }

  Future<void> getConsultantData() async {
    GetConsultant? tempConsultant = await ApiServices.getConsultant(
      context,
      Constants.getBusiness + businessId.toString(),
      user,
    );

    if (tempConsultant != null) {
      if (tempConsultant.consultants.isNotEmpty) {
        await locator<LocalStorageService>().saveData(
          key: 'consultants',
          value: tempConsultant.consultants.map((e) => e.toJson()).toList(),
        );
      }
    }
  }

  Future<void> getBusinessBranch() async {
    GetBranch? tempBusiness = await ApiServices.getBusinessBranch(
      context,
      Constants.getBusinessBranch + businessId.toString(),
      user,
    );

    if (tempBusiness != null) {
      if (tempBusiness.businessBranches!.isNotEmpty) {
        await locator<LocalStorageService>().saveData(
          key: 'branches',
          value: tempBusiness.businessBranches!.map((e) => e.toJson()).toList(),
        );
      }
    }
  }

  Future<void> getCustomerData() async {
    GetCustomer? tempCustomer = await ApiServices.getCustomer(
      context,
      Constants.getCustomers + businessId.toString(),
      user,
    );
    if (tempCustomer != null) {
      if (tempCustomer.customers!.isNotEmpty) {
        await locator<LocalStorageService>().saveData(
          key: 'customers',
          value: tempCustomer.customers!.map((e) => e.toJson()).toList(),
        );
      }
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
        await locator<LocalStorageService>().saveData(
          key: 'businessData',
          value: tempBusiness.business!.map((e) => e.toJson()).toList(),
        );
      }
    }
  }
}
