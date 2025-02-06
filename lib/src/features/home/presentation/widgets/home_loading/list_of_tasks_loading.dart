import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/horizontal_line.dart';

class ListOfTasksLoading extends StatelessWidget {
  const ListOfTasksLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (_) => _taskViewer()),
    );
  }

  Widget _taskViewer({double? bottomMargin}) {
    return Container(
      height: 123.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.white),
      ),
      margin: EdgeInsets.only(bottom: bottomMargin ?? 16.h),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        spacing: 12.h,
        children: [
          _taskViewerDetails(),
          const HorizontalLine(
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _taskViewerDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Container(
                width: 100.w,
                height: 20.h,
                color: AppColors.white,
              ),
              Container(
                width: 100.w,
                height: 20.h,
                color: AppColors.white,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Container(
              width: 100.w,
              height: 20.h,
              color: AppColors.white,
            ),
            Container(
              width: 100.w,
              height: 20.h,
              color: AppColors.white,
            ),
          ],
        ),
      ],
    );
  }
}
