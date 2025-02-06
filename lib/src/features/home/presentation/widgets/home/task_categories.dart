import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/tasks_type_count.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/task_category_button.dart';

class TaskCategories extends StatelessWidget {
  const TaskCategories({super.key, required this.tasksTypeCount});
  final TasksTypeCount tasksTypeCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Row(
          spacing: 16.w,
          children: [
            TaskCategoryButton(
              width: 163.w,
              text: AppStrings.newTasks,
              count: tasksTypeCount.newTasksCount,
              color: AppColors.darkBlue,
              iconString: Assets.assetsSvgsToDo,
              onTap: () {
                getIt<HomeCubit>().showTasksInSelectCategory(
                  categoryHeader: AppStrings.newTasks,
                );
              },
            ),
            TaskCategoryButton(
              width: 163.w,
              text: AppStrings.inProgress,
              count: tasksTypeCount.inProgressTaskCount,
              color: AppColors.orange,
              iconString: Assets.assetsSvgsClock,
              onTap: () {
                getIt<HomeCubit>().showTasksInSelectCategory(
                  categoryHeader: AppStrings.inProgressTasks,
                );
              },
            ),
          ],
        ),
        Row(
          spacing: 16.w,
          children: [
            TaskCategoryButton(
              width: 163.w,
              text: AppStrings.completed,
              count: tasksTypeCount.completedTasksCount,
              color: AppColors.teal,
              iconString: Assets.assetsSvgsCheckCircle,
              onTap: () {
                getIt<HomeCubit>().showTasksInSelectCategory(
                  categoryHeader: AppStrings.completedTasks,
                );
              },
            ),
            TaskCategoryButton(
              width: 163.w,
              text: AppStrings.outDated,
              count: tasksTypeCount.outDatedTasksCount,
              color: AppColors.rosePink,
              iconString: Assets.assetsSvgsCrossCircle,
              onTap: () {
                getIt<HomeCubit>().showTasksInSelectCategory(
                  categoryHeader: AppStrings.outDatedTasks,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
