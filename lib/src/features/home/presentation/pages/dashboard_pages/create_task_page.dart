import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/helpers/validators.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/widgets/custom_text_field.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/custom_header.dart';
import 'package:task_app/src/features/home/presentation/widgets/create_task/create_task_button.dart';
import 'package:task_app/src/features/home/presentation/widgets/create_task/custom_date_picker.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          verticalSpace(height: 24),
          CustomHeader(
            title: AppStrings.createNewTask,
            onBackTap: () {
              getIt<DashboardCubit>().changePage(0);
            },
          ),
          verticalSpace(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: getIt<CreateTaskCubit>().createTaskFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: AppStrings.taskNameHint,
                      controller: getIt<CreateTaskCubit>().taskNameController,
                      header: AppStrings.taskName,
                      focusNode: getIt<CreateTaskCubit>().taskNameFocusNode,
                      validator: (value) => Validators.nameValidator(value),
                    ),
                    verticalSpace(height: 20),
                    CustomTextField(
                      hintText: AppStrings.noteHint,
                      controller: getIt<CreateTaskCubit>().noteController,
                      header: AppStrings.note,
                      focusNode: getIt<CreateTaskCubit>().noteFocusNode,
                      validator: (value) => Validators.nameValidator(value),
                    ),
                    verticalSpace(height: 20),
                    Text(
                      AppStrings.date,
                      style: AppTextStyles.robotoFont16Black100Medium1,
                    ),
                    verticalSpace(height: 12),
                    CustomDatePicker(
                      onDateSelected: (List<DateTime> value) {
                        log('selected date ${value[0]}');
                        getIt<CreateTaskCubit>().selectDateAndTime(value[0]);
                      },
                    ),
                    verticalSpace(height: 15),
                    const CreateTaskButton(),
                    verticalSpace(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
