import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.height,
      required this.onTap,
      this.text,
      this.width,
      this.child,
      this.color})
      : assert(
          (text != null) ^ (child != null),
          'Provide either a text or a child, but not both.',
        );
  final double? height;
  final double? width;
  final VoidCallback onTap;
  final String? text;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width?.w ?? double.infinity,
        height: height?.h ?? 48.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.darkBlue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Center(
              child: child ??
                  Text(
                    text!,
                    style: AppTextStyles.robotoFont16White100SemiBold1,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
