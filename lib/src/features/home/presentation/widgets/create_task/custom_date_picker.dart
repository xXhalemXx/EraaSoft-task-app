import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key, required this.onDateSelected});
  final void Function(List<DateTime> value) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        currentDate: DateTime.now(),
        hideMonthPickerDividers: true,
        hideYearPickerDividers: true,
        animateToDisplayedMonthDate: false,
        dynamicCalendarRows: true,
        selectedMonthTextStyle:
            AppTextStyles.sfProDisplayFont22DarkBlue100Medium1,
        selectedYearTextStyle:
            AppTextStyles.sfProDisplayFont22DarkBlue100Medium1,
        selectedDayTextStyle:
            AppTextStyles.sfProDisplayFont22DarkBlue100Medium1,
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: AppColors.darkBlue.withValues(alpha: 0.2),
        dayTextStyle: AppTextStyles.sfProDisplayFont18_5Black100Regular1,
        todayTextStyle: AppTextStyles.sfProDisplayFont18_5DarkBlue100Regular1,
        weekdayLabels: [
          AppStrings.sun,
          AppStrings.mon,
          AppStrings.tue,
          AppStrings.wed,
          AppStrings.thu,
          AppStrings.fri,
          AppStrings.sat
        ],
        weekdayLabelTextStyle: AppTextStyles.sfProDisplayFont12Gray100SemiBold1,
        nextMonthIcon: _arrow(angle: 90),
        lastMonthIcon: _arrow(angle: -90),
        yearTextStyle: AppTextStyles.sfProDisplayFont18_5Black100Regular1,
        controlsHeight: 45.h,
        modePickerBuilder: ({
          required viewMode,
          required monthDate,
          isMonthPicker,
        }) {
          return _header(
            isMonthPicker: isMonthPicker,
            monthDate: monthDate,
          );
        },
      ),
      value: const [],
      onValueChanged: onDateSelected,
    );
  }

  Widget _header({bool? isMonthPicker, required DateTime monthDate}) => Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                isMonthPicker == true
                    ? DateFormat('MMM')
                        .format(DateTime(0, monthDate.month))
                        .toUpperCase()
                    : monthDate.year.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          isMonthPicker == true
              ? const SizedBox.shrink()
              : _arrow(
                  angle: 90,
                  width: 20,
                  height: 20,
                ),
        ],
      );

  Widget _arrow({required int angle, double? width, double? height}) =>
      Transform.rotate(
        angle: angle * 3.14 / 180,
        child: SvgPicture.asset(
          Assets.assetsSvgsUpArrow,
          width: width ?? 35.w,
          height: height ?? 35.h,
          colorFilter:
              const ColorFilter.mode(AppColors.darkBlue, BlendMode.srcIn),
        ),
      );
}
