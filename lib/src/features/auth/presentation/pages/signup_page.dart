import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/widgets/custom_text_field.dart';
import 'package:task_app/src/core/widgets/empty_app_bar.dart';
import 'package:task_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_app/src/core/helpers/validators.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/auth_button.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/bottom_text.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/logo_with_background.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/title_and_subtitle.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // no app bar but used to override status bar color and status bar icons as provided in figma design
      appBar: const EmptyAppBar(),
      // to show the background color behind the app bar
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: getIt<AuthCubit>().signUpFormKey,
            // start of UI
            child: Column(
              children: [
                // to show eraasoft logo and gary background
                const LogoWithBackground(),
                verticalSpace(height: 56),
                // show create account and Create a new account for free texts
                const TitleAndSubtitle(
                  title: AppStrings.createAccount,
                  subtitle: AppStrings.signupSubtitle,
                ),
                verticalSpace(height: 32),
                // name text filed
                CustomTextField(
                  header: AppStrings.name,
                  hintText: AppStrings.nameHint,
                  controller: getIt<AuthCubit>().signupNameController,
                  validator: (value) {
                    return Validators.nameValidator(value);
                  },
                ),
                verticalSpace(height: 16),
                // email text filed
                CustomTextField(
                  header: AppStrings.email,
                  hintText: AppStrings.emailHint,
                  controller: getIt<AuthCubit>().signupEmailController,
                  validator: (value) {
                    return Validators.emailValidator(value);
                  },
                ),
                verticalSpace(height: 16),
                // password text filed
                CustomTextField(
                  hintText: AppStrings.passwordHint,
                  controller: getIt<AuthCubit>().signupPasswordController,
                  header: AppStrings.password,
                  obscureText: true,
                  validator: (value) {
                    return Validators.passwordValidator(value);
                  },
                ),
                verticalSpace(height: 24),
                // register button
                AuthButton(
                  text: AppStrings.register,
                  onTap: () {
                    getIt<AuthCubit>().register();
                  },
                ),
                verticalSpace(height: 24),
                // login text if user already have an account
                BottomText(
                  firstSection: AppStrings.haveAccount,
                  secondSection: AppStrings.login,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
