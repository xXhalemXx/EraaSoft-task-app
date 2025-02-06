import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/widgets/custom_button.dart';
import 'package:task_app/src/core/widgets/empty_app_bar.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const EmptyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  Assets.assetsGifSuccess,
                  height: 200.h,
                  width: 200.w,
                ),
                verticalSpace(height: 24),
                Text(
                  AppStrings.taskCreatedSuccessfully,
                  style: AppTextStyles.robotoFont20Black100Medium1,
                ),
                const Spacer(),
                CustomButton(
                  onTap: () => getIt<CreateTaskCubit>()
                      .homeButtonPressed(context: context),
                  text: AppStrings.home,
                ),
                verticalSpace(height: 48),
              ],
            ),
          ),
        ));
  }
}
