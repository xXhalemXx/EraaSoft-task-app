import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/widgets/custom_button.dart';

class CustomSuccessDialog extends StatelessWidget {
  const CustomSuccessDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: AppColors.white,
      child: Container(
        width: 343.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(height: 24),
            Image.asset(
              Assets.assetsGifSuccess,
              height: 100.h,
              width: 100.w,
            ),
            verticalSpace(height: 16),
            Text(
              AppStrings.taskStatusChangedSuccessfully,
              style: AppTextStyles.robotoFont16Black100Medium1,
            ),
            verticalSpace(height: 24),
            CustomButton(
                onTap: () => Navigator.pop(context), text: AppStrings.ok),
          ],
        ),
      ),
    );
  }
}
