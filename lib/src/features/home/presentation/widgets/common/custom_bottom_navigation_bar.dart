import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24.h,
      right: 16.w,
      child: Container(
        height: 80.h,
        width: 343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: AppColors.lightBlue,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return Row(
                spacing: 12.w,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  bottomNavigationBarButton(
                    svg: Assets.assetsSvgsHome,
                    isSelected: state.currentIndex == 0 ? true : false,
                    index: 0,
                    name: AppStrings.home,
                  ),
                  bottomNavigationBarButton(
                    svg: Assets.assetsSvgsPlus,
                    isSelected: state.currentIndex == 1 ? true : false,
                    index: 1,
                    name: AppStrings.addTask,
                  ),
                  bottomNavigationBarButton(
                    svg: Assets.assetsSvgsUser,
                    isSelected: state.currentIndex == 2 ? true : false,
                    index: 2,
                    name: AppStrings.profile,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBarButton(
      {required String svg,
      required String name,
      required bool isSelected,
      required int index}) {
    return Flexible(
      flex: isSelected ? 3 : 1,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkBlue : AppColors.lightBlue,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: GestureDetector(
          onTap: () {
            getIt<DashboardCubit>().changePage(index);
          },
          child: Center(
            child: isSelected
                ? _selectedItem(svg: svg, name: name)
                : _unSelectedItem(svg: svg),
          ),
        ),
      ),
    );
  }

  Widget _unSelectedItem({required String svg}) => Container(
        height: 56.h,
        width: 56.w,
        decoration: BoxDecoration(
          color: AppColors.lighterGray,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: SvgPicture.asset(
            svg,
            height: 20.h,
            width: 20.w,
            colorFilter:
                const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
        ),
      );
  Widget _selectedItem({required String svg, required String name}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svg,
            height: 20.h,
            width: 20.w,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
          horizontalSpace(width: 8),
          Text(
            name,
            style: AppTextStyles.robotoFont14White100Medium1,
          ),
        ],
      );
}
