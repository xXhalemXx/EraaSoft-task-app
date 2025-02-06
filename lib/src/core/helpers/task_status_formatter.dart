import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';

class TaskStatusFormatter {
  static String getStatusText(Task task) {
    // check if task is outdated
    if (task.deliveryDate.isBefore(DateTime.now()) &&
        task.status != HomeCubitStrings.completed) {
      return AppStrings.outDated;
    } else {
      // if not outdated use task status
      switch (task.status) {
        case HomeCubitStrings.completed:
          return AppStrings.completed;
        case HomeCubitStrings.inProgress:
          return AppStrings.inProgress;
        case HomeCubitStrings.pending:
          return AppStrings.newTask;
        // dead case but must add for null safety
        default:
          return AppStrings.newTask;
      }
    }
  }

  static Color getStatusColor(Task task) {
    // check if task is outdated
    if (task.deliveryDate.isBefore(DateTime.now()) &&
        task.status != HomeCubitStrings.completed) {
      return AppColors.rosePink;
    } else {
      // if not outdated use task status
      switch (task.status) {
        case HomeCubitStrings.completed:
          return AppColors.teal;
        case HomeCubitStrings.inProgress:
          return AppColors.orange;
        case HomeCubitStrings.pending:
          return AppColors.darkBlue;
        // dead case but must add for null safety
        default:
          return AppColors.darkBlue;
      }
    }
  }
}
