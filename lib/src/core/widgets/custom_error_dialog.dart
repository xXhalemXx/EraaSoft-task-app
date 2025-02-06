import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/widgets/custom_button.dart';

class CustomErrorDialog extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String content;
  final VoidCallback? onTap;
  final String? buttonText;
  const CustomErrorDialog({
    super.key,
    this.title,
    required this.content,
    this.titleStyle,
    this.onTap,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(title ?? AppStrings.error,
          style: titleStyle ?? AppTextStyles.robotoFont24Red100SemiBold1),
      content: Text(
        content,
        style: AppTextStyles.robotoFont16Black100Medium1,
        textAlign: TextAlign.center,
      ),
      actions: [
        CustomButton(
            onTap: onTap ?? () => Navigator.pop(context),
            text: buttonText ?? AppStrings.ok),
      ],
    );
  }
}
