import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/spacing.dart';

class TaskCategoryButton extends StatelessWidget {
  const TaskCategoryButton(
      {super.key,
      required this.text,
      required this.count,
      required this.color,
      required this.iconString,
      this.width,
      this.height,
      required this.onTap});

  final String text;
  final int count;
  final Color color;
  final String iconString;
  final double? width;
  final double? height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: height ?? 56.h,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: color,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              horizontalSpace(width: 8),
              _taskButtonIcon(iconString: iconString),
              horizontalSpace(width: 8),
              _taskButtonText(text: text, count: count, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskButtonText(
      {required String text, required int count, required Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTextStyles.robotoFont14White100Medium1,
        ),
        verticalSpace(height: 4),
        Text(
          '$count ${AppStrings.task}',
          style: AppTextStyles.robotoFont12White50Regular1,
        ),
      ],
    );
  }

  Widget _taskButtonIcon({required String iconString}) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.offWhite.withValues(alpha: 0.3),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconString,
          height: 16.h,
          width: 16.w,
        ),
      ),
    );
  }
}
