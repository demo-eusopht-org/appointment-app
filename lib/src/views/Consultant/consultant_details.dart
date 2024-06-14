import 'dart:developer';

import 'package:appointment_management/api/auth_api/api_services/api_services.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_schedule.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/get_services.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/views/Appointments/appointment_booking_doctor.dart';
import 'package:appointment_management/src/views/Customer/add_customer.dart';
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';

class ConsultantDetails extends StatefulWidget {
  final Consultant consultant;
  const ConsultantDetails({super.key, required this.consultant});

  @override
  State<ConsultantDetails> createState() => _ConsultantDetailsState();
}

class _ConsultantDetailsState extends State<ConsultantDetails> {
  Consultant? consultant;

  dynamic user;

  List<ConsultantSchedule>? consultantSchedules;

  bool isLoading = false;

  List<Branch> branches = [];

  List<Service> services = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  // List<String> monthTexts = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
  // List<String> timeTexts = ['09:00', '11:00', '02:00', '03:00', '11:00'];

  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: 'Consultant Details ',
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: CircleAvatar(
                            radius: 45.sp,
                            backgroundImage: consultant!.imageName != null
                                ? CachedNetworkImageProvider(
                                    '${Constants.consultantImageBaseUrl}${consultant!.imageName}',
                                  )
                                : AssetImage(AppImages.noImage)
                                    as ImageProvider<Object>,
                          ),
                        ),
                        // CachedNetworkImage(
                        //   imageUrl:
                        //       '${Constants.consultantImageBaseUrl}${consultant!.imageName}',
                        //   fit: BoxFit.cover,
                        //   width: MediaQuery.sizeOf(context).width * 0.4,
                        //   height: MediaQuery.sizeOf(context).height * 0.18,
                        //   errorWidget: (context, url, error) {
                        //     return Container(
                        //       height:
                        //           MediaQuery.sizeOf(context).height * 0.18,
                        //       decoration: BoxDecoration(
                        //         border:
                        //             Border.all(color: Colors.grey.shade100),
                        //       ),
                        //       child: Image.asset(
                        //         fit: BoxFit.contain,
                        //         AppImages.noImage,
                        //         width:
                        //             MediaQuery.sizeOf(context).width * 0.4,
                        //       ),
                        //     );
                        //   },
                        // ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                              text: consultant!.name!.toUpperCaseFirst(),
                              fSize: 15.sp,
                              fWeight: FontWeight.w700,
                            ),
                            textWidget(
                              text: '${consultant!.field}',
                              fWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Row(
                              children: [
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: AppColors.primary,
                                //     borderRadius: BorderRadius.circular(6),
                                //   ),
                                //   width: 66,
                                //   height: 47,
                                //   child: Column(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.center,
                                //     children: [
                                //       Column(
                                //         children: [
                                //           textWidget(
                                //             text: 'Patients',
                                //
                                //             fWeight: FontWeight.w600,
                                //             color: Colors.white,
                                //           ),
                                //           SizedBox(
                                //             height: 5,
                                //           ),
                                //           textWidget(
                                //             text: '2.5K',
                                //
                                //             fWeight: FontWeight.w700,
                                //             color: Colors.white,
                                //           ),
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 5.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          textWidget(
                                            text: 'Experience ',
                                            fWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          textWidget(
                                            text:
                                                '${consultant!.experience ?? '0'}',
                                            fWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 15),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: SizedBox(
                    //           height: 50,
                    //           child: Stack(
                    //             children: [
                    //               Positioned(
                    //                 top: 10,
                    //                 left: 50,
                    //                 child: Container(
                    //                   height: 30,
                    //                   width:
                    //                       MediaQuery.of(context).size.width * 0.3,
                    //                   decoration: BoxDecoration(
                    //                     color: AppColors.ratingbarColor,
                    //                     borderRadius: BorderRadius.only(
                    //                       topRight: Radius.circular(50),
                    //                       bottomRight: Radius.circular(50),
                    //                     ),
                    //                   ),
                    //                   child: Center(
                    //                     child: RatingBar.builder(
                    //                       updateOnDrag: true,
                    //                       glowColor: AppColors.starColor,
                    //                       glowRadius: 5.0,
                    //                       initialRating: 3,
                    //                       minRating: 1,
                    //                       direction: Axis.horizontal,
                    //                       allowHalfRating: true,
                    //                       itemCount: 5,
                    //                       itemSize: 14,
                    //                       itemBuilder: (context, _) => Icon(
                    //                         Icons.star,
                    //                         color: AppColors.starColor,
                    //                       ),
                    //                       onRatingUpdate: (rating) {
                    //                         print(rating);
                    //                       },
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Positioned(
                    //                 left: 20,
                    //                 child: Container(
                    //                   alignment: Alignment.center,
                    //                   height: 50,
                    //                   width: 50,
                    //                   decoration: BoxDecoration(
                    //                     color: AppColors.primary,
                    //                     borderRadius: BorderRadius.circular(100),
                    //                   ),
                    //                   child: textWidget(
                    //                     text: '4.0',
                    //                     fSize: 16,
                    //                     fWeight: FontWeight.w600,
                    //                     color: Colors.white,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 154,
                    //         height: 41,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           color: AppColors.primary,
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             textWidget(
                    //               text: 'Satisfied Patients',
                    //               fWeight: FontWeight.w600,
                    //
                    //               color: Colors.white,
                    //             ),
                    //             textWidget(
                    //               text: '2K+',
                    //               fWeight: FontWeight.w600,
                    //               fSize: 15.0,
                    //               color: Colors.white,
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                            text: 'About Consultant',
                            fSize: 18.0,
                            fWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textWidget(
                            text: getAbout(),
                            fSize: 15.0,
                            fWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (services.isEmpty)
                            Center(
                              child: textWidget(
                                text: 'No services found',
                                fWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            )
                          else
                            textWidget(
                              text: 'Services',
                              fSize: 18.0,
                              fWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (services.isNotEmpty)
                            for (int i = 0; i < services.length; i++)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textWidget(
                                          text: '${services[i].serviceName}',
                                          fSize: 15.sp,
                                          fWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        textWidget(
                                          text: '${services[i].price}',
                                          fSize: 15.sp,
                                          fWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget(
                                text: 'Schedule',
                                fSize: 15.sp,
                                fWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (consultantSchedules!.isEmpty)
                            textWidget(
                              text: 'No Schedule found',
                              fWeight: FontWeight.w500,
                            ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: consultantSchedules!.length,
                              itemBuilder: (context, index) {
                                // bool isSelected = (index == selectedDateIndex);

                                // sortAppointmentList();

                                Branch? consultantBranch;
                                ConsultantSchedule consultantSchedule =
                                    consultantSchedules![index];
                                final tempConsultantBranches = branches
                                    .where((element) =>
                                        element.id ==
                                        consultantSchedule.branchId)
                                    .toList();

                                if (tempConsultantBranches.isNotEmpty) {
                                  consultantBranch =
                                      tempConsultantBranches.first;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   selectedDateIndex = index;
                                    // });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                        vertical: 10.sp,
                                      ),
                                      width: MediaQuery.sizeOf(context).width /
                                          2.7,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.black),
                                        color:
                                            // isSelected ?
                                            // isBooked
                                            //     ? AppColors.primary
                                            //     : isConducted
                                            //         ? AppColors.success
                                            //         : AppColors.danger,
                                            AppColors.primary,
                                        // :   AppColors.ratingbarColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (consultantBranch != null)
                                            textWidget(
                                              text:
                                                  '${consultantBranch.address}',
                                              maxline: 3,
                                              textOverFlow:
                                                  TextOverflow.ellipsis,
                                              color: Colors.white,
                                              fWeight: FontWeight.w700,
                                            ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          textWidget(
                                            text: consultantSchedule.day
                                                .toString(),
                                            color:
                                                // isSelected ?
                                                Colors.white,
                                            // : Colors.black,
                                            fWeight: FontWeight.w700,
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          textWidget(
                                            text:
                                                'Start: ${consultantSchedule.startTime!.fromStringtoFormattedTime()}',
                                            color:
                                                // isSelected ?
                                                Colors.white,
                                            // : Colors.black,
                                            fWeight: FontWeight.w700,
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          textWidget(
                                            text:
                                                'End: ${consultantSchedule.endTime!.fromStringtoFormattedTime()}',
                                            color:
                                                // isSelected ?
                                                Colors.white,
                                            // : Colors.black,
                                            fWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Container(
                          //   height: 62,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     shrinkWrap: true,
                          //     itemCount: 5,
                          //     itemBuilder: (context, index) {
                          //       bool isSelected =
                          //           (index == selectedDateIndex);

                          //       return GestureDetector(
                          //         onTap: () {
                          //           setState(() {
                          //             selectedDateIndex = index;
                          //           });
                          //         },
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //             horizontal: 4.0,
                          //           ),
                          //           child: Container(
                          //             alignment: Alignment.center,
                          //             width: 80,
                          //             height: 62,
                          //             decoration: BoxDecoration(
                          //               border:
                          //                   Border.all(color: Colors.grey),
                          //               color: isSelected
                          //                   ? AppColors.primary
                          //                   : AppColors.ratingbarColor,
                          //               borderRadius:
                          //                   BorderRadius.circular(6),
                          //             ),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 textWidget(
                          //                   text: monthTexts[index],
                          //                   color: isSelected
                          //                       ? Colors.white
                          //                       : Colors.black,
                          //                   fSize: 18.0,
                          //                   fWeight: FontWeight.w800,
                          //                 ),
                          //                 textWidget(
                          //                   text: '29',
                          //                   color: isSelected
                          //                       ? Colors.white
                          //                       : Colors.black,
                          //                   fSize: 18.0,
                          //                   fWeight: FontWeight.w800,
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 18, vertical: 5),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       textWidget(
                    //         text: 'Time ',
                    //         fSize: 18.0,
                    //         fWeight: FontWeight.w700,
                    //         color: Colors.black,
                    //       ),
                    //       SizedBox(height: 10),
                    //       Container(
                    //         height: 62,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           shrinkWrap: true,
                    //           itemCount: 5,
                    //           itemBuilder: (context, index) {
                    //             bool isSelected =
                    //                 (index == selectedTimeIndex);

                    //             return GestureDetector(
                    //               onTap: () {
                    //                 setState(() {
                    //                   selectedTimeIndex = index;
                    //                 });
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                   horizontal: 4.0,
                    //                 ),
                    //                 child: Container(
                    //                   alignment: Alignment.center,
                    //                   width: 80,
                    //                   height: 62,
                    //                   decoration: BoxDecoration(
                    //                     border:
                    //                         Border.all(color: Colors.grey),
                    //                     color: isSelected
                    //                         ? AppColors.primary
                    //                         : AppColors.ratingbarColor,
                    //                     borderRadius:
                    //                         BorderRadius.circular(6),
                    //                   ),
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: [
                    //                       textWidget(
                    //                         text: timeTexts[index],
                    //                         color: isSelected
                    //                             ? Colors.white
                    //                             : Colors.black,
                    //                         fSize: 18.0,
                    //                         fWeight: FontWeight.w800,
                    //                       ),
                    //                       textWidget(
                    //                         text: 'AM',
                    //                         color: isSelected
                    //                             ? Colors.white
                    //                             : Colors.black,
                    //                         fSize: 18.0,
                    //                         fWeight: FontWeight.w800,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       CupertinoPageRoute(
                    //         builder: (context) => AppointmentBookingDoctor(),
                    //       ),
                    //     );
                    //   },
                    //   child: Stack(
                    //     children: [
                    //       Image.asset(AppImages.button),
                    //       Positioned.fill(
                    //         child: ShaderMask(
                    //           shaderCallback: (Rect bounds) {
                    //             return LinearGradient(
                    //               begin: Alignment.centerLeft,
                    //               end: Alignment.centerRight,
                    //               colors: [Colors.white, AppColors.primary],
                    //               stops: [0.4, 0.4], // Halfway
                    //             ).createShader(bounds);
                    //           },
                    //           child: Center(
                    //             child: textWidget(
                    //               textAlign: TextAlign.center,
                    //               text: 'Book Appointment',
                    //               color: Colors.white,
                    //               fSize: 17.0,
                    //               fWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
    );
  }

  getAbout() {
    if (consultant!.about != null && consultant!.about!.isNotEmpty) {
      return '${consultant!.about}';
    }
    return '--';
  }

  Future<void> _init() async {
    setState(() {
      isLoading = true;
    });
    consultant = widget.consultant;
    user = locator<LocalStorageService>().getData(key: 'user');
    branches = GetLocalData.getBranches();
    services = GetLocalData.getServices();
    await getConsultantSchedule();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getConsultantSchedule() async {
    GetConsultantSchedule? tempConsultantSchedule =
        await ApiServices.getConsultantSchedule(
      context,
      Constants.getConsultantSchedule + consultant!.id.toString(),
      user,
    );

    if (tempConsultantSchedule != null) {
      if (tempConsultantSchedule.consultantSchedule!.isNotEmpty &&
          tempConsultantSchedule.consultantSchedule!.first.cbid != null) {
        consultantSchedules = tempConsultantSchedule.consultantSchedule;
      } else {
        consultantSchedules = [];
      }
    } else {
      consultantSchedules = [];
    }
    for (var i = 0; i < consultantSchedules!.length; i++) {
      log('consultantSchedules ${consultantSchedules![i].toJson()}');
    }

    setState(() {});
  }
}
