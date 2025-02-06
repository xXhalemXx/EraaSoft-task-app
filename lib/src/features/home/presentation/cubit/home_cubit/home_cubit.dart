import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/core/models/tasks_type_count.dart';
import 'package:task_app/src/core/networking/network_exceptions.dart';
import 'package:task_app/src/core/routes/router.dart';
import 'package:task_app/src/core/widgets/custom_error_dialog.dart';
import 'package:task_app/src/features/home/domain/use_cases/home/calculate_tasks_count.dart';
import 'package:task_app/src/features/home/domain/use_cases/home/get_tasks_from_db_use_case.dart';
import 'package:task_app/src/features/home/domain/use_cases/home/get_tasks_use_case.dart';
import 'package:task_app/src/features/home/domain/use_cases/home/update_task_data_use_case.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/success_dialog.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getTasksUseCase,
    required this.updateTaskDataUseCase,
  }) : super(HomeState.initial());
  final GetTasksUseCase getTasksUseCase;
  final UpdateTaskDataUseCase updateTaskDataUseCase;
  final CalculateTasksCount calculateTasksCount = CalculateTasksCount();
  final GetTasksFromDbUseCase getTasksFromDatabase = GetTasksFromDbUseCase();

  ///********************************    UI Related   ************************************* */
  // to set selected item
  void selectItem(String item) {
    log('selected item $item');
    emit(state.copyWith(selectedItem: item));
  }

  // to check if drop down items  open or close to change ui of drop down button
  void checkIfDropDownItemsState(bool isOpen) {
    emit(state.copyWith(isDropDownOpen: isOpen));
  }

  // show tasks in selected category's
  void showTasksInSelectCategory({required String categoryHeader}) {
    emit(
      state.copyWith(
          showTasksInSpecificCategory: true,
          categoryHeader: categoryHeader,
          tasksInSpecificCategory:
              _getTasksInSpecificCategory(categoryHeader: categoryHeader)),
    );
  }

  // close category viewer
  void closeCategoryViewer() {
    emit(
      state.copyWith(showTasksInSpecificCategory: false, categoryHeader: ''),
    );
  }

  ///********************************    Logic Related   ************************************* */

  /// this function to get tasks from api or database
  /// and sync database with server
  Future<void> getAllTasks() async {
    try {
      // set home state loading
      emit(state.copyWith(currentHomeState: CurrentHomeState.loading));
      // check if connected to internet or not and call api or database
      List<TaskSyncStatus> tasks = await getTasksUseCase();
      // show data and change state
      emit(
        state.copyWith(
          tasksWithSyncBool: tasks,
          currentHomeState: CurrentHomeState.loaded,
          tasksTypeCount:
              calculateTasksCount(tasks.map((e) => e.task).toList()),
        ),
      );
    } catch (e) {
      // if error happened get tasks from database and show it
      List<TaskSyncStatus> tasks = await getTasksFromDatabase();
      // set home state loaded
      emit(
        state.copyWith(
          currentHomeState: CurrentHomeState.loaded,
          tasksWithSyncBool: tasks,
          tasksTypeCount:
              calculateTasksCount(tasks.map((e) => e.task).toList()),
        ),
      );
      // check if token is expired if yes logout user and navigate to login
      // else show error dialog pending on error
      NetworkExceptions.getErrorMessageWithTokenCheck(e);
    }
  }

  Future<void> changeTaskStatus(
      {required TaskSyncStatus taskWithBoolSync,
      required String newStatus}) async {
    try {
      // if user trays to make task out dated
      if (newStatus == HomeCubitStrings.outDated &&
          !taskWithBoolSync.task.deliveryDate.isBefore(DateTime.now())) {
        Navigator.pop(AppRouter.navigatorKey.currentContext!);
        showDialog(
          context: AppRouter.navigatorKey.currentContext!,
          builder: (_) => const CustomErrorDialog(
              content: AppStrings.youCantChangeTaskToBeOutDated),
        );
        return;
      }
      // check if task out of date and user want to make it [in progress -pending- completed];
      if (taskWithBoolSync.task.deliveryDate.isBefore(DateTime.now()) &&
          taskWithBoolSync.task.status != HomeCubitStrings.completed) {
        // if task is out dated
        Navigator.pop(AppRouter.navigatorKey.currentContext!);
        showDialog(
          context: AppRouter.navigatorKey.currentContext!,
          builder: (_) => const CustomErrorDialog(
              content: AppStrings.youCantChangeOutDatedTask),
        );
      } else {
        if (taskWithBoolSync.task.status != newStatus) {
          await updateTaskDataUseCase(
              task: taskWithBoolSync.task, status: newStatus);
          Navigator.pop(AppRouter.navigatorKey.currentContext!);
          await getAllTasks();
          if (state.showTasksInSpecificCategory) {
            showTasksInSelectCategory(categoryHeader: state.categoryHeader);
          }
          showDialog(
            context: AppRouter.navigatorKey.currentContext!,
            builder: (_) => SuccessDialog(
              text: AppStrings.taskUpdatedSuccessfully,
              onTap: () async {
                Navigator.pop(AppRouter.navigatorKey.currentContext!);
              },
            ),
          );
          return;
        }
        Navigator.pop(AppRouter.navigatorKey.currentContext!);
      }
    } catch (e) {
      // check if token is expired if yes logout user and navigate to login
      // else show error dialog pending on error
      NetworkExceptions.getErrorMessageWithTokenCheck(e);
    }
  }

  List<TaskSyncStatus> _getTasksInSpecificCategory(
      {required String categoryHeader}) {
    String taskStatus = _getHomeCubitStringFromCatHeader(categoryHeader);
    List<TaskSyncStatus> tasksWithSyncBool = state.tasksWithSyncBool;
    List<TaskSyncStatus> tasksInCategory = [];
    for (TaskSyncStatus taskWithSyncBool in tasksWithSyncBool) {
      if (taskWithSyncBool.task.status == taskStatus &&
          !taskWithSyncBool.task.deliveryDate.isBefore(DateTime.now())) {
        tasksInCategory.add(taskWithSyncBool);
      }
      if (taskWithSyncBool.task.deliveryDate.isBefore(DateTime.now()) &&
          taskWithSyncBool.task.status != HomeCubitStrings.completed &&
          taskStatus == HomeCubitStrings.outDated) {
        tasksInCategory.add(taskWithSyncBool);
      }
    }
    return tasksInCategory;
  }

  _getHomeCubitStringFromCatHeader(String categoryHeader) {
    switch (categoryHeader) {
      case AppStrings.newTasks:
        return HomeCubitStrings.pending;
      case AppStrings.inProgressTasks:
        return HomeCubitStrings.inProgress;
      case AppStrings.completedTasks:
        return HomeCubitStrings.completed;
      case AppStrings.outDatedTasks:
        return HomeCubitStrings.outDated;
      default:
        return HomeCubitStrings.pending;
    }
  }
}
