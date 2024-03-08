import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appointment_management/theme/dark/dark_theme.dart';
import 'package:appointment_management/theme/light/light_theme.dart';

class MyTextStyles {
  static final TextStyle boldTextWhite = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );
  static final TextStyle boldtitleblack = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
  static final TextStyle continuewith = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xff1e1c21)
    ),

  );

  static final TextStyle formtext = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    )
  );
  static final TextStyle onboardingheading = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      )
  );
  static final TextStyle normalblacktext = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
}
