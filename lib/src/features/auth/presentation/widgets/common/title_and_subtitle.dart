import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/spacing.dart';

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override

  /// Returns a Column widget containing the title and subtitle text widgets.
  ///
  /// The title has a font size of 24, is semi-bold, and is black.
  ///
  /// The subtitle has a font size of 14, is regular, and is gray.
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.robotoFont24Black100SemiBold1,
        ),
        verticalSpace(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.robotoFont14Gray100Regular1,
        ),
      ],
    );
  }
}
