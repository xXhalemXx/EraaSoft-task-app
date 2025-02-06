import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';

class TaskCategoriesLoading extends StatelessWidget {
  const TaskCategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Row(
          spacing: 16.w,
          children: [
            Container(
              height: 56.h,
              width: 163.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
            ),
            Container(
              height: 56.h,
              width: 163.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
            ),
          ],
        ),
        Row(
          spacing: 16.w,
          children: [
            Container(
              height: 56.h,
              width: 163.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
            ),
            Container(
              height: 56.h,
              width: 163.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
