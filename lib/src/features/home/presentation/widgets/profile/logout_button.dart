import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/widgets/custom_button.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomButton(
          color: AppColors.red,
          // if the state is loading then text will be null to show the circular progress indicator
          text: state.currentLogoutState == CurrentLogoutState.loading
              ? null
              : AppStrings.logout,
          // if the state is not loading then child will be null to show the text
          onTap: () {
            if (state.currentLogoutState != CurrentLogoutState.loading) {
              getIt<ProfileCubit>().logout();
            }
          },
          child: state.currentLogoutState == CurrentLogoutState.loading
              ? SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                )
              : null,
        );
      },
    );
  }
}
