import 'package:appointment_management/src/views/auth/widgets/custom_button.dart';
import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
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
  final TextEditingController patientController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
            )),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/add_consultant_vector10.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/Vector 8.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                    // Account Icon in Circle
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.buttonColor,
                      ),
                      child: Image(
                        image: AssetImage(AppImages.account),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
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
                      controller: patientController,
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
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: RoundedElevatedButton(
                        onPressed: () {},
                        text: 'Add',
                        borderRadius: 6,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
