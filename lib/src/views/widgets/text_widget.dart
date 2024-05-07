import 'package:flutter/material.dart';

Widget textWidget({
  required String text,
  Color? color,
  FontWeight? fWeight,
  double? fSize,
  int? maxline,
  bool underlined = false,
  TextAlign? textAlign,
  TextOverflow? textOverFlow,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fWeight,
      fontSize: fSize,
      fontFamily: 'Poppins',
      decoration: underlined ? TextDecoration.underline : null,
      // decorationColor: Colors.blue,
      // decorationThickness: 2.0,
    ),
    textAlign: textAlign,
    maxLines: maxline,
    overflow: textOverFlow,
  );
}

Widget textWidget2({
  required String text,
  Color? color,
  FontWeight? fWeight,
  double? fSize,
  int? maxline,
  bool underlined = false,
  TextAlign? textAlign,
  TextOverflow? textOverFlow,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fWeight,
      fontSize: fSize,
      fontFamily: 'Montserrat',
      decoration: underlined ? TextDecoration.underline : null,
      // decorationColor: Colors.blue,
      // decorationThickness: 2.0,
    ),
    textAlign: textAlign,
    maxLines: maxline,
    overflow: textOverFlow,
  );
}
