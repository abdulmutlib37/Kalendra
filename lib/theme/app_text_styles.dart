import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headline48ExtraBold({Color? color}) => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.textBlack,
        height: 1.05,
      );

  static TextStyle headline28ExtraBold({Color? color}) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.textBlack,
        height: 1.2,
      );

  static TextStyle body20Regular({Color? color}) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textBlack,
      );

  static TextStyle button20ExtraBold({Color? color}) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.white,
      );

  static TextStyle logo18Bold({Color? color}) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textBlack,
      );
}
