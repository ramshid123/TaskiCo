import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kText({
  required String text,
  Color color = Colors.white,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Material(
    color: Colors.transparent,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget kGoogleText({
  required String text,
  Color color = Colors.white,
  double fontSize = 14,
  required String fontFamily,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: GoogleFonts.getFont(
      fontFamily,
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    ),
  );
}

Widget kHeight(double height) {
  return SizedBox(height: height);
}

Widget kWidth(double width) {
  return SizedBox(width: width);
}
