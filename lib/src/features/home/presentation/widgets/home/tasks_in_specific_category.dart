import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/core/models/tasks_type_count.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/custom_header.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/no_tasks_yet.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/list_of_tasks.dart';

class TasksInSpecificCategory extends StatelessWidget {
  const TasksInSpecificCategory(
      {super.key,
      required this.header,
      required this.tasksWithSyncBool,
      required this.tasksTypeCount});
  final String header;
  final List<TaskSyncStatus> tasksWithSyncBool;
  final TasksTypeCount tasksTypeCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(height: 24),
              CustomHeader(
                title: header,
                onBackTap: () {
                  getIt<HomeCubit>().closeCategoryViewer();
                },
              ),
              verticalSpace(height: 24),
              tasksWithSyncBool.isEmpty
                  ? const NoTasksYet()
                  : ListOfTasks(
                      tasksWithSyncBool: tasksWithSyncBool,
                      tasksTypeCount: tasksTypeCount,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
