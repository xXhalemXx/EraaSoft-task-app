import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/helpers/logout_services.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/core/routes/router.dart';
import 'package:task_app/src/core/widgets/custom_error_dialog.dart';

class GetTasksFromDbUseCase {
  /// get tasks from database if user connected to internet but exception happened
  Future<List<TaskSyncStatus>> call() async {
    try {
      return await HiveDatabaseHelper.getLocalDatabaseTasks();
    } catch (e) {
      // clear user data
      LogoutServices.clearUserDataToLogout();
      // show error dialog
      showDialog(
        barrierDismissible: false,
        context: AppRouter.navigatorKey.currentContext!,
        builder: (_) => CustomErrorDialog(
          content: AppStrings.noInternetAndLocalDatabaseCorrupted,
          buttonText: AppStrings.login,
          onTap: () {
            Navigator.pop(AppRouter.navigatorKey.currentContext!);
            Navigator.of(AppRouter.navigatorKey.currentContext!)
                .pushNamedAndRemoveUntil(
                    RoutesNames.login, (Route<dynamic> route) => false);
          },
        ),
      );
      return [];
    }
  }
}
