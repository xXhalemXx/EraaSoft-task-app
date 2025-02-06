import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/core/widgets/custom_text_field.dart';
import 'package:task_app/src/core/widgets/empty_app_bar.dart';
import 'package:task_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_app/src/core/helpers/validators.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/auth_button.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/bottom_text.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/title_and_subtitle.dart';
import 'package:task_app/src/features/auth/presentation/widgets/common/logo_with_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          // form to validate the email and password
          child: Form(
            key: getIt<AuthCubit>().loginFormKey,
            //start of the page UI
            child: Column(
              children: [
                // to show eraasoft logo and gary background
                const LogoWithBackground(),
                verticalSpace(height: 56),
                // show login and Login to your account texts
                const TitleAndSubtitle(
                  title: AppStrings.login,
                  subtitle: AppStrings.loginSubtitle,
                ),
                verticalSpace(height: 32),
                // email text filed
                CustomTextField(
                  header: AppStrings.email,
                  hintText: AppStrings.emailHint,
                  controller: getIt<AuthCubit>().loginEmailController,
                  validator: (value) {
                    return Validators.emailValidator(value);
                  },
                ),
                verticalSpace(height: 16),
                // password text filed
                CustomTextField(
                  header: AppStrings.password,
                  hintText: AppStrings.passwordHint,
                  controller: getIt<AuthCubit>().loginPasswordController,
                  obscureText: true,
                  validator: (value) {
                    return Validators.passwordValidator(value);
                  },
                ),
                verticalSpace(height: 24),
                // login button
                AuthButton(
                  text: AppStrings.login,
                  onTap: () => getIt<AuthCubit>().login(),
                ),
                verticalSpace(height: 24),
                // signup text if user doesn't have an account
                BottomText(
                  firstSection: AppStrings.dontHaveAccount,
                  secondSection: AppStrings.createAccount,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.signup);
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
