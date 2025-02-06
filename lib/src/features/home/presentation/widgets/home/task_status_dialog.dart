import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/constants/assets.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/core/models/tasks_type_count.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/task_category_button.dart';

class TaskStatusDialog extends StatelessWidget {
  const TaskStatusDialog(
      {super.key,
      required this.taskWithBoolSync,
      required this.tasksTypeCount});
  final TaskSyncStatus taskWithBoolSync;
  final TasksTypeCount tasksTypeCount;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        width: 343.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12.h,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppStrings.changeTaskStatus,
                style: AppTextStyles.robotoFont16Black100Medium1,
              ),
            ),
            TaskCategoryButton(
              text: AppStrings.newTasks,
              count: tasksTypeCount.newTasksCount,
              color: AppColors.darkBlue,
              iconString: Assets.assetsSvgsToDo,
              onTap: () {
                getIt<HomeCubit>().changeTaskStatus(
                    taskWithBoolSync: taskWithBoolSync,
                    newStatus: HomeCubitStrings.pending);
              },
            ),
            TaskCategoryButton(
              text: AppStrings.inProgress,
              count: tasksTypeCount.inProgressTaskCount,
              color: AppColors.orange,
              iconString: Assets.assetsSvgsClock,
              onTap: () {
                getIt<HomeCubit>().changeTaskStatus(
                    taskWithBoolSync: taskWithBoolSync,
                    newStatus: HomeCubitStrings.inProgress);
              },
            ),
            TaskCategoryButton(
              text: AppStrings.completed,
              count: tasksTypeCount.completedTasksCount,
              color: AppColors.teal,
              iconString: Assets.assetsSvgsCheckCircle,
              onTap: () {
                getIt<HomeCubit>().changeTaskStatus(
                    taskWithBoolSync: taskWithBoolSync,
                    newStatus: HomeCubitStrings.completed);
              },
            ),
            TaskCategoryButton(
              text: AppStrings.outDated,
              count: tasksTypeCount.outDatedTasksCount,
              color: AppColors.rosePink,
              iconString: Assets.assetsSvgsCrossCircle,
              onTap: () {
                getIt<HomeCubit>().changeTaskStatus(
                    taskWithBoolSync: taskWithBoolSync,
                    newStatus: HomeCubitStrings.outDated);
              },
            ),
          ],
        ),
      ),
    );
  }
}
