import 'dart:developer';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Assign%20Consultant%20Schedule/assign_consultant_schedule.dart';
import 'package:appointment_management/src/views/Assign%20branch/assign_branch.dart';
import 'package:appointment_management/src/views/Consultant/add_consultant.dart';
import 'package:appointment_management/src/views/Consultant/consultant_details.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/custom_drawer.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/assets.dart';

class ConsultantDirectory extends StatefulWidget {
  const ConsultantDirectory({super.key});

  @override
  State<ConsultantDirectory> createState() => _ConsultantDirectoryState();
}

class _ConsultantDirectoryState extends State<ConsultantDirectory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  dynamic user, businessId;

  // GetCustomer? customerData;
  // bool findingCustomer = true;

  List<Consultant>? consultants;

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
            title: 'Consultant Directory',
            leadingIcon: Icon(
              Icons.arrow_back_outlined,
            ),
            leadingIconOnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            action: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddConsultant(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              )
            ]
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
            // : consultants == null
            //     ? Center(
            //         child: textWidget(
            //           text: 'No consultant found to fetch their consultants',
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
              if (consultants!.isEmpty)
                Expanded(
                  child: Center(
                    child: textWidget(
                      text: 'No consultants found.',
                      fWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: consultants!.length,
                    itemBuilder: (context, index) {
                      final consultant = consultants![index];

                      log('image ${Constants.customerImageBaseUrl}${consultant.imageName}');
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
                                    backgroundImage: consultant.imageName !=
                                            null
                                        ? CachedNetworkImageProvider(
                                            '${Constants.customerImageBaseUrl}${consultant.imageName}')
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
                                                ConsultantDetails(
                                              consultant: consultant,
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
                                                  text: '${consultant.name}',
                                                  fWeight: FontWeight.w600,
                                                ),
                                                textWidget(
                                                  text: '${consultant.email}',
                                                ),
                                                Row(
                                                  children: [
                                                    customButton(
                                                      title: 'Assign Branch',
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder: (context) =>
                                                                AssignBranch(
                                                              consultant:
                                                                  consultant,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    customButton(
                                                        title:
                                                            'Assign Schedule',
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  AssignConsultantSchedule(
                                                                updateSchedule:
                                                                    false,
                                                                consultantId:
                                                                    consultant
                                                                        .id,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
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

  Container customButton({required String title, required Function onTap}) {
    return Container(
      padding: EdgeInsets.all(
        5.sp,
      ),
      margin: EdgeInsets.all(
        5.sp,
      ),
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(5.sp)),
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: Container(
          child: textWidget(
            text: title,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _init() async {
    user = locator<LocalStorageService>().getData(key: 'user');
    businessId = locator<LocalStorageService>().getData(key: 'businessId');

    consultants = GetLocalData.getConsultants();
  }
}
