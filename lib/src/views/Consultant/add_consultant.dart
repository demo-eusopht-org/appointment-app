import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:flutter/material.dart';

import '../../resources/assets.dart';
import '../auth/widgets/custom_textfield.dart';

class AddConsultant extends StatefulWidget {
  const AddConsultant({super.key});

  @override
  State<AddConsultant> createState() => _AddConsultantState();
}

class _AddConsultantState extends State<AddConsultant> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController patientsController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: textWidget(
              text: 'Add Consultant',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          // customAppBar(
          //   context: context,
          //   leadingIcon: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(
          //       Icons.arrow_back,
          //     ),
          //   ),
          //   title: 'Add Consultant',
          // ),
          body: Container(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: Image.asset(
                //     "assets/images/add_consultant_vector10.png",
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                        InkWell(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Appcolors.lightTheme.primaryColor,
                                ),
                                child: Image(
                                  image: AssetImage(
                                    AppImages.camera,
                                  ),
                                ),
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.1),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 10,
                                  child: Image.asset(
                                    height: 15,
                                    width: 15,
                                    color: Colors.black,
                                    AppImages.camera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015),
                        textWidget2(
                          text: 'Add Photo',
                          fSize: 14,
                          fWeight: FontWeight.w400,
                        ),
                        CustomTextField(
                          hintText: "Name",
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "Field",
                          controller: fieldController,
                        ),
                        CustomTextField(
                          hintText: "Email",
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "Total Patients",
                          controller: patientsController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "Experience",
                          controller: expController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "About",
                          controller: aboutController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 106,
                          child: RoundedElevatedButton(
                            borderRadius: 6,
                            onPressed: () {},
                            text: 'Add',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: SafeArea(
            child: Image.asset(
              "assets/images/add_consultant_vector10.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SafeArea(
            child: Image.asset(
              "assets/images/Vector 8.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
