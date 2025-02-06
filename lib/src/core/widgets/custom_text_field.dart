import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/spacing.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.validator,
    this.focusNode,
    required this.header,
  });
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String header;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header
        Text(
          header,
          style: AppTextStyles.robotoFont16Black100Medium1,
        ),
        verticalSpace(height: 12),
        //text form filed
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray, width: 1.w),
              borderRadius: BorderRadius.circular(20.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                  color: AppColors.darkBlue, width: 1.5.w), // Activation color
            ),
            hintStyle: AppTextStyles.robotoFont14Gray100Regular1,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          ),
        ),
      ],
    );
  }
}
