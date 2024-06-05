import 'dart:convert';
import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/resources/textstyle.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/customer/add_customer.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProcedureList extends StatefulWidget {
  const ProcedureList({super.key});

  @override
  State<ProcedureList> createState() => _ProcedureListState();
}

class _ProcedureListState extends State<ProcedureList> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final serviceNameController = TextEditingController();
  final servicePriceController = TextEditingController();

  dynamic user, businessId;
  GetServices? servicesData;
  bool findingServices = true;
  List<String> servicesAction = ['Update', 'Delete'];

  Api? api;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        title: 'Services List',
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
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.close,
        //     ),
        //   )
        // ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      serviceNameController.clear();
                      servicePriceController.clear();
                      serviceAction(
                        'Add Service',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget2(
                          text: "Add Service",
                          fSize: 10.sp,
                          fWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          findingServices
              ? SizedBox()
              : servicesData == null
                  ? SizedBox()
                  : Container(
                      height: 30,
                      // width: 360,
                      color: AppColors.buttonColor,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: textWidget2(
                                text: 'SERVICE NAME',
                                fSize: 10.sp,
                                fWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: textWidget2(
                                text: 'PRICE',
                                fSize: 10.sp,
                                fWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: textWidget2(
                                text: 'CREATED AT ',
                                fSize: 10.sp,
                                fWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: textWidget2(
                                text: 'Action',
                                fSize: 10.sp,
                                fWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          )
                        ],
                      ),
                    ),
          SizedBox(
            height: 10,
          ),
          findingServices
              ? Loader()
              : servicesData == null
                  ? textWidget(text: 'No services found')
                  : Expanded(
                      child: ListView.builder(
                          itemCount: servicesData!.services?.length ?? 0,
                          itemBuilder: (context, index) {
                            Service service = servicesData!.services![index];

                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          service.serviceName ?? 'No name',
                                          style: MyTextStyles.normalBlacktext
                                              .copyWith(
                                            fontSize: 12.sp,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                        // child: Container(
                                        //   alignment: Alignment.center,
                                        //   height: 30,
                                        //   child: ElevatedButton(
                                        //     onPressed: () {},
                                        //     style: ElevatedButton.styleFrom(
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(6),
                                        //       ),
                                        //       backgroundColor:
                                        //           AppColors.buttonColor,
                                        //       foregroundColor: Colors.white,
                                        //     ),
                                        //     child: Text(
                                        //       service.serviceName ?? 'No name',
                                        //       style: MyTextStyles
                                        //           .normalWhitetext
                                        //           .copyWith(
                                        //         fontSize: 12.sp,
                                        //         overflow: TextOverflow.ellipsis,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            '${service.price ?? '0'}',
                                            style: MyTextStyles.normalBlacktext
                                                .copyWith(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            utils.pkFormatDate(
                                                service.createdAt.toString(),
                                                'onlyDate'),
                                            style: MyTextStyles.normalBlacktext
                                                .copyWith(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            PopupMenuButton(
                                              iconColor: AppColors.buttonColor,
                                              onSelected:
                                                  (String selectedValue) {
                                                if (selectedValue == 'Update') {
                                                  serviceNameController.text =
                                                      service.serviceName!;
                                                  servicePriceController.text =
                                                      service.price!.toString();
                                                  serviceAction(
                                                    'Update Service',
                                                    service: service,
                                                  );
                                                } else if (selectedValue ==
                                                    'Delete') {
                                                  CustomDialogue
                                                      .displayDialogye(
                                                    context,
                                                    message:
                                                        'Are you sure you want to delete?',
                                                    okayTap: () {
                                                      deleteService(service);
                                                    },
                                                  );
                                                }
                                              },
                                              itemBuilder: (context) {
                                                return servicesAction
                                                    .map((e) => PopupMenuItem(
                                                        value: e,
                                                        child: Text(e)))
                                                    .toList();
                                              },
                                            ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     CustomDialogue.displayDialogye(
                                            //       context,
                                            //       message:
                                            //           'Are you sure you want to delete?',
                                            //       okayTap: () {},
                                            //     );
                                            //   },
                                            //   child: CircleAvatar(
                                            //     backgroundColor: Colors.red,
                                            //     radius: 14,
                                            //     child: Icon(
                                            //       Icons.delete,
                                            //       size: 13,
                                            //       color: Colors.white,
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                              ],
                            );
                          }),
                    )
        ],
      ),
    );
  }

  Future<void> createService() async {
    Navigator.pop(context);
    try {
      dynamic res = await api!.createService({
        "service_name": serviceNameController.text.trim(),
        "price": servicePriceController.text.trim(),
        "business_id": businessId
      });
      log('res service ${res}');

      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogue.message(context: context, message: res['message']);
      } else {
        if (res.toString().contains('message')) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
          Navigator.pop(context);
        } else {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
      _init();
    } catch (e) {
      log('Something went wrong in create service api $e');
      CustomDialogue.message(
          context: context, message: 'Service not created $e');
    }
  }

  Future<void> _init() async {
    api ??= Api(
      dio,
      baseUrl: Constants.baseUrl,
    );

    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');

    getServices();
  }

  Future<void> getServices() async {
    try {
      final res = await ApiServices.getServices(
        context,
        Constants.getService + businessId.toString(),
        user,
      );
      if (res != null) {
        servicesData = res;

        await locator<LocalStorageService>().delete('services');

        await locator<LocalStorageService>().saveData(
          key: 'services',
          value: res.services!.map((e) => e.toJson()).toList(),
        );
      }
      setState(() {
        findingServices = false;
      });
    } catch (e) {
      log('Something went wrong in getServices Api $e');
      setState(() {
        findingServices = false;
      });
    }
  }

  Future<void> updateService(Service service) async {
    try {
      dynamic res = await api!.updateService({
        "service_name": serviceNameController.text.trim(),
        "price": servicePriceController.text.trim(),
        "service_id": service.id,
        "business_id": service.businessId,
      });

      Navigator.pop(context);
      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogue.message(context: context, message: res['message']);
      } else {
        if (res.toString().contains('message')) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
          Navigator.pop(context);
        } else {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
      _init();
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Service not update $e');
      log('ERROR IN updateService ${e}', stackTrace: stack);
    }
  }

  Future<void> deleteService(Service service) async {
    try {
      dynamic res = await api!.deleteService({
        "service_id": service.id,
      });
      log('message ${res['status']}');
      log('message ${res['message']}');

      Navigator.pop(context);
      if (res['status'] == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogue.message(context: context, message: res['message']);
      } else {
        if (res.toString().contains('message')) {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['message']);
          Navigator.pop(context);
        } else {
          // ignore: use_build_context_synchronously
          CustomDialogue.message(context: context, message: res['error']);
        }
      }
      _init();
    } catch (e, stack) {
      CustomDialogue.message(
          context: context, message: 'Service not deleted $e');

      log('ERROR IN deleteService ${e}', stackTrace: stack);
    }
  }

  void serviceAction(String title, {Service? service}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(
            horizontal: 20.sp,
          ),
          title: textWidget(
            text: title,
            fSize: 16.0,
            fWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: "Service Name:",
                    fSize: 10.0,
                    fWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: serviceNameController,
                      style: TextStyle(fontSize: 12),
                      // cursorHeight: 15,
                      decoration: const InputDecoration(
                        isDense: true,
                        // constraints: BoxConstraints(
                        //   maxHeight: 25,
                        // ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  textWidget(
                    text: "Service Price:",
                    fSize: 10.0,
                    fWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: servicePriceController,
                      style: TextStyle(fontSize: 12),
                      // cursorHeight: 15,
                      decoration: const InputDecoration(
                        isDense: true,
                        // constraints: BoxConstraints(
                        //   maxHeight: 25,
                        // ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                height: 33,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(41),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (title == 'Add Service') {
                      await createService();
                    } else if (title == 'Update Service') {
                      log('calling service ${service}');
                      await updateService(service!);
                    }
                  },
                  child: textWidget(
                    text: getButtonTitle(title),
                    fWeight: FontWeight.w700,
                    fSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String getButtonTitle(String title) {
    return title == 'Add Service' ? ' Save' : ' Update';
  }
}
