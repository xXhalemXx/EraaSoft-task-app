import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/helpers/validators.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/widgets/custom_text_field.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/custom_header.dart';
import 'package:task_app/src/features/home/presentation/widgets/profile/logout_button.dart';
import 'package:task_app/src/features/home/presentation/widgets/profile/update_profile_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: getIt<ProfileCubit>().profileFormKey,
        child: Column(
          children: [
            verticalSpace(height: 24),
            // show profile header and back button
            CustomHeader(
              title: AppStrings.profile,
              onBackTap: () {
                getIt<DashboardCubit>().changePage(0);
              },
            ),
            verticalSpace(height: 24),
            // name text fields
            CustomTextField(
              hintText: AppStrings.nameHint,
              controller: getIt<ProfileCubit>().nameController,
              header: AppStrings.name,
              validator: (value) {
                return Validators.nameUpdateValidator(
                  value,
                );
              },
            ),
            verticalSpace(height: 20),
            // email text field
            CustomTextField(
              hintText: AppStrings.emailHint,
              controller: getIt<ProfileCubit>().emailController,
              header: AppStrings.email,
              validator: (value) {
                return Validators.emailUpdateValidator(
                  value,
                );
              },
            ),
            verticalSpace(height: 30),
            // update button
            const UpdateProfileButton(),
            verticalSpace(height: 15),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
