import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/appointment/get_all_appointment.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/customer/customer_details.dart';
import 'package:appointment_management/src/views/widgets/cached_network_image.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  // GetCustomer? customerData;
  // bool findingCustomer = true;

  List<Customer>? customers;

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
          // action: [
          //   Image.asset(
          //     AppImages.notification,
          //     width: 50,
          //   ),
          // ],
        ),
        drawer: CustomDrawer(),
        body:
            //  findingCustomer
            //     ? const Loader()
            //     :
            // : customers == null
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
              if (customers!.isEmpty)
                Expanded(
                  child: Center(
                    child: textWidget(
                      text: 'No customers found.',
                      fWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: customers!.length,
                //     itemBuilder: (context, index) {
                //       final customer = customers![index];
                //       return Column(
                //         children: [
                //           Divider(
                //             color: Colors.grey.shade300,
                //           ),
                //           GestureDetector(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 CupertinoPageRoute(
                //                   builder: (context) => const CustomerDetails(),
                //                 ),
                //               );
                //             },
                //             child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 CircleAvatar(
                //                   radius: 30.sp,
                //                   backgroundImage: customer.imageName != null
                //                       ? CachedNetworkImageProvider(
                //                           '${Constants.customerImageBaseUrl}${customer.imageName}')
                //                       : AssetImage(AppImages.noImage)
                //                           as ImageProvider<Object>,
                //                 ),
                //                 SizedBox(
                //                   width: 5.sp,
                //                 ),
                //                 Expanded(
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: [
                //                       Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           textWidget(
                //                             text: '${customer.name}',
                //                             fWeight: FontWeight.w600,
                //                           ),
                //                           textWidget(
                //                             text: '${customer.email}',
                //                           ),
                //                           textWidget(
                //                             text: '${customer.address}',
                //                           ),
                //                         ],
                //                       ),
                //                       Row(
                //                         children: [
                //                           GestureDetector(
                //                             onTap: () async {
                //                               utils.launchPhoneApp(
                //                                 context,
                //                                 customer.mobile!,
                //                               );
                //                             },
                //                             child: const Icon(
                //                               Icons.phone,
                //                               color: Colors.black,
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 10.sp,
                //                           ),
                //                           const Icon(
                //                             Icons.arrow_forward_ios,
                //                             color: AppColors.black,
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // )
                Expanded(
                  child: ListView.builder(
                    itemCount: customers!.length,
                    itemBuilder: (context, index) {
                      final customer = customers![index];

                      log('image ${Constants.customerImageBaseUrl}${customer.imageName}');
                      return Column(
                        children: [
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              double radius = constraints.maxWidth / 10;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: radius,
                                    backgroundImage: customer.imageName != null
                                        ? CachedNetworkImageProvider(
                                            '${Constants.customerImageBaseUrl}${customer.imageName}')
                                        : AssetImage(AppImages.noImage)
                                            as ImageProvider<Object>,
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                CustomerDetails(
                                              customer: customer,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                textWidget(
                                                  text: '${customer.name}',
                                                  fWeight: FontWeight.w600,
                                                ),
                                                textWidget(
                                                  text: '${customer.email}',
                                                ),
                                                textWidget(
                                                  text: '${customer.address}',
                                                  maxline: 2,
                                                  textOverFlow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  utils.launchPhoneApp(
                                                    context,
                                                    customer.mobile!,
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.phone,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.sp,
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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

    customers = GetLocalData.getCustomers();
  }
}
