import 'dart:developer';

import 'package:appointment_management/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({
  required String text,
  Color? color,
  FontWeight? fWeight,
  double? fSize,
  int? maxline,
  bool underlined = false,
  TextAlign? textAlign,
  TextOverflow? textOverFlow,
  bool? isUpperCase,
}) {
  return Text(
    (isUpperCase != null && !isUpperCase) ? text : text.toUpperCaseFirst(),
    style: GoogleFonts.poppins(
      color: color,
      fontWeight: fWeight ?? FontWeight.normal,
      fontSize: fSize ?? 12.sp,
      decoration: underlined ? TextDecoration.underline : null,
    ),
    textAlign: textAlign,
    maxLines: maxline,
    overflow: textOverFlow,
  );
}
