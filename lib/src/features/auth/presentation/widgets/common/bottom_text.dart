import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';

class BottomText extends StatelessWidget {
  const BottomText(
      {super.key,
      required this.firstSection,
      required this.secondSection,
      required this.onTap});
  final String firstSection;
  final String secondSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: firstSection,
          style: AppTextStyles.robotoFont12Black100Regular1,
          children: [
            TextSpan(
              text: ' $secondSection',
              recognizer: TapGestureRecognizer()..onTap = onTap,
              style: AppTextStyles.robotoFont12DarkBlue100SemiBold1,
            ),
          ],
        ),
      ),
    );
  }
}
