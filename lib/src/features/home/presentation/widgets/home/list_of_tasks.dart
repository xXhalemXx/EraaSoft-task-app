import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/date_time_manger.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/helpers/task_status_formatter.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/core/models/tasks_type_count.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/horizontal_line.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/task_status_dialog.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks(
      {super.key,
      required this.tasksWithSyncBool,
      required this.tasksTypeCount});
  final List<TaskSyncStatus> tasksWithSyncBool;
  final TasksTypeCount tasksTypeCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...tasksWithSyncBool.map(
          (taskWithSyncBool) => _taskViewer(
            taskWithSyncBool: taskWithSyncBool,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => TaskStatusDialog(
                        taskWithBoolSync: taskWithSyncBool,
                        tasksTypeCount: tasksTypeCount,
                      ));
            },
          ),
        ),
        verticalSpace(height: 100),
      ],
    );
  }

  Widget _taskViewer({
    double? bottomMargin,
    required VoidCallback onTap,
    required TaskSyncStatus taskWithSyncBool,
  }) {
    return Container(
      height: 123.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.black.withValues(alpha: 0.1)),
      ),
      margin: EdgeInsets.only(bottom: bottomMargin ?? 16.h),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        spacing: 10.h,
        children: [
          _taskViewerDetails(task: taskWithSyncBool.task),
          const HorizontalLine(),
          _taskViewerStatus(
            onTap: onTap,
            status: TaskStatusFormatter.getStatusText(taskWithSyncBool.task),
            color: TaskStatusFormatter.getStatusColor(taskWithSyncBool.task),
            isSynced: taskWithSyncBool.needUpload,
          ),
        ],
      ),
    );
  }

  Widget _taskViewerDetails({required Task task}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                task.title,
                style: AppTextStyles.robotoFont16Black100Medium1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                task.description,
                style: AppTextStyles.robotoFont12Gray100Regular1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              DateTimeManger.dateComparison(task.deliveryDate),
              style: AppTextStyles.robotoFont12Gray100SemiBold1,
            ),
            Text(
              DateTimeManger.formatTime(task.createdAt),
              style: AppTextStyles.robotoFont12Gray100Regular1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _taskViewerStatus(
      {required VoidCallback onTap,
      required String status,
      required bool isSynced,
      required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 76.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              status,
              style: AppTextStyles.robotoFont12White100SemiBold1,
            ),
          ),
        ),
        const Spacer(),
        Visibility(
          visible: isSynced,
          child: Icon(
            Icons.sync,
            color: AppColors.gray.withValues(alpha: 0.4),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Center(
            child: Text(
              AppStrings.changeStatus,
              style: AppTextStyles.robotoFont12DarkBlue100SemiBold1.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
