import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/widgets/custom_button.dart';
import 'package:task_app/src/features/home/presentation/widgets/create_task/custom_date_picker.dart';

class CustomDatePickerDialog extends StatelessWidget {
  const CustomDatePickerDialog(
      {super.key, required this.onDateSelected, required this.onTap});
  final void Function(List<DateTime> value) onDateSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          spacing: 12.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(height: 1),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppStrings.selectNewDate,
                style: AppTextStyles.robotoFont16Black100Medium1,
              ),
            ),
            CustomDatePicker(
              onDateSelected: onDateSelected,
            ),
            CustomButton(onTap: onTap, text: AppStrings.select),
            verticalSpace(height: 1),
          ],
        ),
      ),
    );
  }
}
