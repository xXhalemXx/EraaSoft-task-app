import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';

class FontWeightHelper {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

class AppTextStyles {
  // to calculate the height of the text use this ratio font height in design (figma) divided by font size

  // we add font family and size and color with percentage and type then font height
  static TextStyle robotoFont24Black100SemiBold1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.black,
    height: 1.sp,
  );
  static TextStyle robotoFont24Red100SemiBold1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.red,
    height: 1.sp,
  );
  static TextStyle robotoFont14Gray100Regular1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.gray,
    height: 1.sp,
  );
  static TextStyle robotoFont14Black100Regular1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black,
    height: 1.sp,
  );
  static TextStyle robotoFont14White100Medium1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white,
    height: 1.sp,
  );
  static TextStyle robotoFont12White100SemiBold1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.white,
    height: 1.sp,
  );
  static TextStyle robotoFont12Black100Regular1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black,
    height: 1.sp,
  );
  static TextStyle robotoFont12White50Regular1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.white.withValues(alpha: 0.5),
    height: 1.sp,
  );
  static TextStyle robotoFont12Gray100Regular1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.gray,
    height: 1.sp,
  );
  static TextStyle robotoFont12Gray100SemiBold1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.gray,
    height: 1.sp,
  );
  static TextStyle robotoFont16Black100Medium1 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.black,
    height: 1.sp,
  );
  static TextStyle robotoFont20Black100Medium1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.black,
    height: 1.sp,
  );
  static TextStyle robotoFont12DarkBlue100SemiBold1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.darkBlue,
    height: 1.sp,
  );
  static TextStyle robotoFont16White100SemiBold1 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.white,
    height: 1.sp,
  );
  static TextStyle sfProDisplayFont18_5Black100Regular1 = TextStyle(
    fontSize: 18.5.sp,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black,
    height: 1.sp,
  );
  static TextStyle sfProDisplayFont18_5DarkBlue100Regular1 = TextStyle(
    fontSize: 18.5.sp,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeightHelper.regular,
    color: AppColors.darkBlue,
    height: 1.sp,
  );
  static TextStyle sfProDisplayFont12Gray100SemiBold1 = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.gray,
    height: 1.sp,
  );
  static TextStyle sfProDisplayFont22DarkBlue100Medium1 = TextStyle(
    fontSize: 22.sp,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlue,
    height: 1.sp,
  );
  static TextStyle sfProDisplayFont15Black100Medium1 = TextStyle(
    fontSize: 15.sp,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.black,
    height: 1.sp,
  );
}
