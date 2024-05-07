import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyles {
  static final TextStyle boldTextWhite = GoogleFonts.poppins(
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
  static final TextStyle continuewith = GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff1e1c21)),
  );

  static final TextStyle formtext = GoogleFonts.poppins(
      textStyle: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ));
  static final TextStyle onboardingheading = GoogleFonts.poppins(
      textStyle: TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  ));
  static final TextStyle smallBlacktext = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
  static final TextStyle normalBlacktext = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
  static final TextStyle smallWhitetext = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
  static final TextStyle normalWhitetext = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}
