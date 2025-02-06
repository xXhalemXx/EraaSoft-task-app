import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/widgets/custom_button.dart';
import 'package:task_app/src/features/auth/presentation/cubit/auth_cubit.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => CustomButton(
        onTap: () {
          if (state.currentAuthState == CurrentAuthState.loading) {
            return;
          }
          onTap();
        },
        // if the state is loading then text will be null to show the circular progress indicator
        text: state.currentAuthState == CurrentAuthState.loading ? null : text,
        // if the state is not loading then child will be null to show the text
        child: state.currentAuthState == CurrentAuthState.loading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : null,
      ),
    );
  }
}
