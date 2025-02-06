import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_colors.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: color ?? AppColors.black.withValues(alpha: 0.1),
    );
  }
}
