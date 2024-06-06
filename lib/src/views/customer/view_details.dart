import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({super.key});

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
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
        title: 'Patient History',
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            AppImages.vectorPatient,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(18),
              color: AppColors.primary,
              height: MediaQuery.sizeOf(context).height * 0.18,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset('assets/images/Vector 1.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset('assets/images/Vector 2.png'),
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.patient,
                          height: 75,
                        ),
                        Expanded(
                          child: GridView(
                            padding: EdgeInsets.only(top: 10, left: 8),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.6,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _buildDetails('Patient Name', 'Abid Ali'),
                              _buildDetails('Height', '5.7'),
                              _buildDetails('Age', '24'),
                              _buildDetails('Email Address', 'Abid@gmail.com'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: textWidget(
                text: 'Note:',
                fSize: 18.0,
                fWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: TextFormField(
                readOnly: true,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText:
                        'Keep up the great work on your health journey; your efforts are truly inspiring!',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ))),
              ),
            )
          ],
        ),
      ]),
    );
  }

  Widget _buildDetails(String text, String label) {
    return Column(
      children: [
        textWidget(
          text: text,
          fSize: 10.0,
          fWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: textWidget(
              text: label,
              fSize: 10.0,
              fWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ],
    );
  }
}
