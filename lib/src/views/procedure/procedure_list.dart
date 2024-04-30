import 'package:appointment_management/src/resources/app_colors.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../auth/widgets/custom_appbar.dart';
import '../auth/widgets/custom_drawer.dart';

class ProcedureList extends StatefulWidget {
  const ProcedureList({super.key});

  @override
  State<ProcedureList> createState() => _ProcedureListState();
}

class _ProcedureListState extends State<ProcedureList> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
        context: context,
        title: 'Procedure List',
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: size.width * 0.43,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          title: textWidget(
                            text: "Add Procedure",
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
                                children: [
                                  textWidget(
                                    text: "Procedure Name:",
                                    fSize: 10.0,
                                    fWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 12),
                                      cursorHeight: 15,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        constraints: BoxConstraints(
                                          maxHeight: 25,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  textWidget(
                                    text: "Procedure Price:",
                                    fSize: 10.0,
                                    fWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 12),
                                      cursorHeight: 15,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        constraints: BoxConstraints(
                                          maxHeight: 25,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Container(
                                width: size.width * 0.4,
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
                                  onPressed: () {},
                                  child: textWidget(
                                    text: 'Save',
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
                  },
                  child: Row(
                    children: [
                      textWidget2(
                        text: "Add Procedure",
                        fSize: 10.0,
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
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            // width: 360,
            color: AppColors.buttonColor,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: textWidget2(
                      text: 'PROCEDURE NAME',
                      fSize: 8.0,
                      fWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: textWidget2(
                      text: 'PRICE',
                      fSize: 9.0,
                      fWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: textWidget2(
                      text: 'CREATED AT ',
                      fSize: 9.0,
                      fWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: textWidget2(
                      text: 'Action',
                      fSize: 9.0,
                      fWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: textWidget2(
                                    text: 'Treatment',
                                    fSize: size.width * 0.02,
                                    fWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    backgroundColor: AppColors.buttonColor,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: textWidget2(
                                  text: '1000',
                                  fSize: 10,
                                  fWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: textWidget(
                                  text: '15/1/24 8:33PM',
                                  fSize: 10,
                                  fWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/Create.png',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            title: textWidget(
                                              text:
                                                  "Are you sure you want to delete?",
                                              fSize: 13.0,
                                              fWeight: FontWeight.w700,
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .buttonColor,
                                                        foregroundColor:
                                                            Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: textWidget(
                                                        text: 'Cancel',
                                                        fSize: 15.0,
                                                        fWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .buttonColor,
                                                        foregroundColor:
                                                            Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: textWidget(
                                                        text: 'OK',
                                                        fSize: 15.0,
                                                        fWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 14,
                                      child: Icon(
                                        Icons.delete,
                                        size: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
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
}
