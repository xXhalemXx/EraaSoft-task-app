import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/models/user_data.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_greetingMessageAndName(), _bellButton()],
    );
  }

  Widget _greetingMessageAndName() => Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Text(
            AppStrings.hello,
            style: AppTextStyles.robotoFont14Gray100Regular1,
          ),
          Text(
            UserData.name ?? '',
            style: AppTextStyles.robotoFont16Black100Medium1,
          ),
        ],
      ));

  Widget _bellButton() => GestureDetector(
        onTap: () {
          log('Bell button tapped');
        },
        child: Container(
          width: 48.w,
          height: 48.h,
          decoration: const BoxDecoration(
            color: AppColors.offWhite,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              Assets.assetsSvgsBell,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      );
}
