import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';

class RecentTasksAndFilterLoading extends StatelessWidget {
  const RecentTasksAndFilterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.recentTasks,
          style: AppTextStyles.robotoFont16Black100Medium1.copyWith(
            color: AppColors.white,
          ),
        ),
        Container(
          width: 120.w,
          height: 40.h,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r)),
        ),
      ],
    );
  }
}
