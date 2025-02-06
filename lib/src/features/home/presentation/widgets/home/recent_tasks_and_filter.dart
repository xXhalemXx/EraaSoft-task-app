import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';

class RecentTasksAndFilter extends StatelessWidget {
  const RecentTasksAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.recentTasks,
          style: AppTextStyles.robotoFont16Black100Medium1,
        ),
        _filterButton(),
      ],
    );
  }

  Widget _filterButton() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            // to set button shape border radius and color and background
            buttonStyleData: _customButtonStyle(isOpened: state.isDropDownOpen),
            // to set dropdown icon shape , padding and color
            iconStyleData: _customIconStyle(),
            // to show content of the button filter icon and filter text
            hint: _filterButtonContent(),
            // to create action when we select an item
            onChanged: (value) =>
                getIt<HomeCubit>().selectItem(value ?? AppStrings.addTask),
            // list of items in the dropdown
            items: [
              _customDropdownMenuItem(
                text: AppStrings.newTasks,
                color: AppColors.darkBlue,
                isSelected: state.selectedItem == AppStrings.newTasks,
              ),
              _customDropdownMenuItem(
                text: AppStrings.inProgress,
                color: AppColors.orange,
                isSelected: state.selectedItem == AppStrings.inProgress,
              ),
              _customDropdownMenuItem(
                text: AppStrings.completed,
                color: AppColors.teal,
                isSelected: state.selectedItem == AppStrings.completed,
              ),
              _customDropdownMenuItem(
                text: AppStrings.outDated,
                color: AppColors.rosePink,
                isSelected: state.selectedItem == AppStrings.outDated,
              ),
            ],
            // to customize the dropdown list style
            dropdownStyleData: _customDropdownStyleData(),
            // to customize the dropdown item style
            menuItemStyleData: _customMenuItemStyleData(),
            onMenuStateChange: (isOpened) {
              getIt<HomeCubit>().checkIfDropDownItemsState(isOpened);
            },
          ),
        );
      },
    );
  }

  ButtonStyleData _customButtonStyle({required bool isOpened}) =>
      ButtonStyleData(
        width: 120.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: isOpened ? Radius.zero : Radius.circular(12.r),
            bottomRight: isOpened ? Radius.zero : Radius.circular(12.r),
          ),
          border: Border.all(
            color: AppColors.black.withValues(alpha: 0.1),
          ),
        ),
      );

  IconStyleData _customIconStyle() => const IconStyleData(
        icon: SizedBox.shrink(),
      );
  Widget _filterButtonContent() => Row(
        children: [
          horizontalSpace(width: 16),
          SvgPicture.asset(
            Assets.assetsSvgsFilter,
            width: 12.w,
            height: 12.h,
          ),
          horizontalSpace(width: 8),
          Text(
            AppStrings.filter,
            style: AppTextStyles.robotoFont14Black100Regular1,
          ),
          horizontalSpace(width: 16),
          SvgPicture.asset(
            Assets.assetsSvgsUpArrow,
            width: 16.w,
            height: 16.h,
          )
        ],
      );
  DropdownStyleData _customDropdownStyleData() => DropdownStyleData(
        padding: EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 7.5.h),
        elevation: 0,
        width: 120.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
          color: AppColors.white,
          border: Border(
            left: BorderSide(
              color: Colors.black.withValues(alpha: 0.1),
            ),
            right: BorderSide(
              color: Colors.black.withValues(alpha: 0.1),
            ),
            bottom: BorderSide(
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ),
        ),
        offset: const Offset(0, 0),
      );
  MenuItemStyleData _customMenuItemStyleData() => MenuItemStyleData(
        height: 32.h,
        padding: EdgeInsets.only(bottom: 4.h),
      );

  DropdownMenuItem<String> _customDropdownMenuItem({
    required String text,
    required Color color,
    required bool isSelected,
  }) =>
      DropdownMenuItem<String>(
        alignment: Alignment.center,
        value: text,
        child: Center(
          child: SizedBox(
            height: 32.h,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.offWhite : null,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpace(width: 8),
                  Text(
                    text,
                    style: AppTextStyles.robotoFont14Black100Regular1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
