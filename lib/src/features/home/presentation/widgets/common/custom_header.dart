import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title, required this.onBackTap});
  final String title;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12.w,
      children: [
        GestureDetector(
          onTap: onBackTap,
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.offWhite,
            ),
            child: Center(
              child: Transform.rotate(
                // rotate 270 degrees
                angle: 270 * 3.14 / 180,
                child: SvgPicture.asset(
                  Assets.assetsSvgsUpArrow,
                  width: 16.w,
                  height: 16.h,
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: AppTextStyles.robotoFont16Black100Medium1,
        )
      ],
    );
  }
}
