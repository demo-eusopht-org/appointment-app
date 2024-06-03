import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/customer/add_customer.dart';
import 'package:appointment_management/src/views/customer/customer_details.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';

class PatientDirectory extends StatefulWidget {
  const PatientDirectory({super.key});

  @override
  State<PatientDirectory> createState() => _PatientDirectoryState();
}

class _PatientDirectoryState extends State<PatientDirectory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  dynamic user, businessId;

  GetCustomer? customerData;
  // bool findingConsultant = true;
  // GetConsultant? consultantsData;
  ValueNotifier<String?> selectedConsultantId = ValueNotifier<String?>(null);

  @override
  @override
  void initState() {
    _init();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: customAppBar(
          context: context,
          title: 'Customer Directory',
          leadingIcon: Icon(
            Icons.arrow_back_outlined,
          ),
          leadingIconOnTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          // leadingIcon: Image.asset(
          //   AppImages.menuIcon,
          // ),
          // leadingIconOnTap: () {
          //   scaffoldKey.currentState!.openDrawer();
          // },
          action: [
            Image.asset(
              AppImages.notification,
              width: 50,
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body:
            //  findingConsultant
            //     ? const Loader()
            //     :
            // consultantsData == null
            //     ? Center(
            //         child: textWidget(
            //           text: 'No consultant found to fetch their customers',
            //           fWeight: FontWeight.bold,
            //         ),
            //       )
            //     :
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // ValueListenableBuilder(
              //   valueListenable: selectedConsultantId,
              //   builder: (context, value, child) {
              //     return DropdownButton<String?>(
              //       value: selectedConsultantId.value,
              //       dropdownColor: AppColors.whiteColor,
              //       hint: textWidget(text: 'Select consultant'),
              //       borderRadius: BorderRadius.circular(10),
              //       isExpanded: true,
              //       items: consultantsData!.consultants
              //           .map((Consultant e) => DropdownMenuItem<String?>(
              //               value: e.id.toString(),
              //               child: textWidget(text: '${e.name}')))
              //           .toList(),
              //       onChanged: (String? value) async {
              //         selectedConsultantId.value = value;
              //         await getCustomerData(selectedConsultantId.value!);
              //       },
              //     );
              //   },
              // ),
              customerData == null
                  ? Expanded(
                      child: Center(
                        child: textWidget(
                          text: 'No customer found for this consultant',
                          fWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: customerData!.customers?.length ?? 0,
                        itemBuilder: (context, index) {
                          final customer = customerData!.customers![index];
                          return Column(
                            children: [
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${Constants.consultantImageBaseUrl}${customer.imagename}',
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.18,
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.18,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade100),
                                        ),
                                        child: Image.asset(
                                          fit: BoxFit.contain,
                                          AppImages.noImage,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.4,
                                        ),
                                      );
                                    },
                                  ),
                                  // Container(
                                  //   height: 75,
                                  //   width: 75,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     border: Border.all(
                                  //       color: Colors.grey.shade100,
                                  //     ),
                                  //   ),
                                  //   child: Image.asset(
                                  //     AppImages.men2,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const CustomerDetails(),
                                        ),
                                      );
                                    },
                                    child: textWidget(
                                      text: '${customer.name}',
                                      fSize: 18.0,
                                      fWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.buttonColor,
                                    radius: 22,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      utils.launchPhoneApp(
                                        context,
                                        customer.mobile!,
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.buttonColor,
                                      radius: 22,
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    )
            ],
          ),
        ));
  }

  Future<void> _init() async {
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');
    // await getConsultantData();
  }

  Future<void> getCustomerData(String consultantId) async {
    GetCustomer? tempCustomer = await ApiServices.getCustomer(
      context,
      Constants.getCustomers + consultantId,
      user,
    );

    if (tempCustomer != null) {
      customerData = tempCustomer;
    }
    setState(() {});
  }

  // Future<void> getConsultantData() async {
  //   try {
  //     final res = await ApiServices.getConsultant(
  //       context,
  //       Constants.getBusiness + businessId.toString(),
  //       user,
  //     );
  //     if (res != null) {
  //       consultantsData = res;
  //     }
  //     setState(() {
  //       findingConsultant = false;
  //     });
  //   } catch (e) {
  //     log('Something went wrong in getConsultant Api $e');
  //     setState(() {
  //       findingConsultant = false;
  //     });
  //   }
  // }
}
