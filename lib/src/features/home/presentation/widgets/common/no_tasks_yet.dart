import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/helpers/spacing.dart';

class NoTasksYet extends StatelessWidget {
  const NoTasksYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        verticalSpace(height: 50),
        Image.asset(
          Assets.assetsImagesNoTasks,
          width: 150.w,
          height: 150.h,
        ),
        Text(
          AppStrings.noTasksHere,
          style: AppTextStyles.robotoFont20Black100Medium1,
        ),
      ],
    );
  }
}
