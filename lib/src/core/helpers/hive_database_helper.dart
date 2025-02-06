import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/helpers/extensions.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';

class HiveDatabaseHelper {
  /// private constructor to avoid creating instance of class
  HiveDatabaseHelper._();

  /// initialize hive and register adapter (TaskAdapter) and open box so we can use it
  /// to add and get tasks
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TaskSyncStatusAdapter());
    await Hive.openBox<TaskSyncStatus>(DataBaseKeys.tasksBox);
  }

  /// add task in local database (box)
  static Future<void> addLocalDatabaseTask(TaskSyncStatus task) async {
    var box = Hive.box<TaskSyncStatus>(DataBaseKeys.tasksBox);
    await box.add(task);
  }

  /// get all tasks from local database order by task id descending or ascending
  /// descending by default
  static Future<List<TaskSyncStatus>> getLocalDatabaseTasks(
      {bool descending = true}) async {
    Box<TaskSyncStatus> box = Hive.box<TaskSyncStatus>(DataBaseKeys.tasksBox);
    return box.values.sortByTaskId(descending: descending);
  }

  static Future<List<Task>> getTasks({bool descending = true}) async {
    Box<TaskSyncStatus> box = Hive.box<TaskSyncStatus>(DataBaseKeys.tasksBox);
    List<Task> tasks = [];
    for (TaskSyncStatus localTask in box.values) {
      tasks.add(localTask.task);
    }
    return tasks.sortByTaskId(descending: descending);
  }

  /// delete task from local database
  static Future<void> deleteTask(Task task) async {
    var box = Hive.box<Task>(DataBaseKeys.tasksBox);
    await box.delete(task);
  }

  // delete all tasks from local database
  static Future<void> deleteAllTasks() async {
    var box = Hive.box<TaskSyncStatus>(DataBaseKeys.tasksBox);
    await box.clear();
  }

  static void updateLocalDatabaseTask({
    required Task oldTask,
    required Task newTask,
    required bool needUpload,
    required bool needUpdate,
  }) {
    // Open the box
    Box<TaskSyncStatus> box = Hive.box<TaskSyncStatus>(DataBaseKeys.tasksBox);
    try {
      // Search for the desired task
      TaskSyncStatus taskSyncStatus = box.values.firstWhere(
        (element) =>
            element.task.title == oldTask.title &&
            element.task.description == oldTask.description &&
            element.task.deliveryDate == oldTask.deliveryDate,
      );

      // Update the found task if it exists
      taskSyncStatus.task = newTask;
      taskSyncStatus.needUpload = needUpload;
      taskSyncStatus.needUpdate = needUpdate;
      taskSyncStatus.save();
    } catch (e) {
      // Handle the case where the task is not found
      log('Task not found: $e');
    }
  }
}
