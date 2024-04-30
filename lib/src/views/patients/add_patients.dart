import 'dart:io';

import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:appointment_management/theme/light/light_theme.dart'
    as Appcolors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/assets.dart';
import '../auth/widgets/custom_textfield.dart';

class AddPatients extends StatefulWidget {
  const AddPatients({super.key});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateofBirthController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController optionalController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _openImagePicker() async {
    final imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = selectedImage;
      });
    }
  }

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
              text: 'Add Patient',
              color: Colors.black,
              fSize: 17.0,
              fWeight: FontWeight.w800,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openImagePicker();
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  height:
                                      MediaQuery.of(context).size.width * 0.28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Appcolors.lightTheme.primaryColor,
                                  ),
                                  child: _selectedImage != null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: ClipOval(
                                            child: Image.file(
                                              File(_selectedImage!.path),
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                              // Ensure the image covers the entire space
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          AppImages.account,
                                        )
                                  // padding: EdgeInsets.all(
                                  //     MediaQuery.of(context).size.width * 0.1),
                                  ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 13,
                                child: Image.asset(
                                  height: 16,
                                  width: 16,
                                  color: Colors.white,
                                  AppImages.camera,
                                ),
                              ),
                            ),
                          ],
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
                          hintText: "Mobile No.",
                          controller: mobileNoController,
                        ),
                        CustomTextField(
                          hintText: "Email",
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "D.O.B",
                          controller: dateofBirthController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "Reference No.",
                          controller: referenceController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: notesController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Notes....',
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: textWidget2(
                            text: 'Optional:',
                            fSize: 15.0,
                            fWeight: FontWeight.w800,
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        CustomTextField(
                          hintText: "Height",
                          controller: optionalController,
                        ),
                        SizedBox(
                          height: 15,
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
      ],
    );
  }
}
