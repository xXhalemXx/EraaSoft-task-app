import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/assets.dart';

class LogoWithBackground extends StatelessWidget {
  const LogoWithBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _backgroundCircle(),
          _logo(),
        ],
      ),
    );
  }

  /// A widget that positions a light gray circular background at a specific
  /// offset within the stack. The circle is centered and has a responsive

  Widget _backgroundCircle() => Positioned(
        //-289.h
        top: -280.h,
        right: -67.w,
        child: Center(
          child: Container(
            width: 477.w,
            height: 477.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightGray,
            ),

            /// show vertical line to verify that the circle in the middle of the screen
            // child: Center(
            //   child: Container(
            //     width: 1.w,
            //     height: 477.h,
            //     decoration: const BoxDecoration(
            //       color: AppColors.red,
            //     ),
            //   ),
            // ),
          ),
        ),
      );

  /// A widget that positions the Eraasoft logo image in the center of the screen
  /// with a specified width and height using responsive dimensions.
  Widget _logo() => Positioned(
        bottom: 16.h,
        right: 125.w,
        child: Center(
          child: Image.asset(
            Assets.assetsImagesEraasoftLogo,
            width: 101.w,
            height: 101.h,
          ),
        ),
      );
}
