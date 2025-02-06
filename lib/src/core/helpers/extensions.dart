import 'package:task_app/src/core/models/api/create_task_model.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension MapExtension<K, V> on Map<K, V>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension ListTasksExtension<T> on List<Task>? {
  bool isTaskInTheList(Task task) => this!.any((element) => element == task);
  bool isCreatedTaskInTheList(CreateTaskModel task) => this!.any(
        (element) {
          if (element.title == task.title &&
              element.description == task.description &&
              element.deliveryDate == DateTime.parse(task.deliveryDate)) {
            return true;
          }
          return false;
        },
      );
}

extension ListLocalDatabaseTasksExtension<T> on List<TaskSyncStatus> {
  bool isTaskInTheList(Task task) {
    for (TaskSyncStatus localDatabaseTask in this) {
      if (localDatabaseTask.task == task) {
        return true;
      }
    }
    return false;
  }

  bool isCreatedTaskInTheList(CreateTaskModel task) => any(
        (element) {
          if (element.task.title == task.title &&
              element.task.description == task.description &&
              element.task.deliveryDate == DateTime.parse(task.deliveryDate)) {
            return true;
          }
          return false;
        },
      );
}

extension IterableLocalDatabaseTaskExtension on Iterable<TaskSyncStatus>? {
  List<TaskSyncStatus> sortByTaskId({required bool descending}) {
    if (this == null || this!.isEmpty) {
      return [];
    }
    List<TaskSyncStatus> sortedList = this!.toList();
    sortedList.sort((a, b) {
      int result = a.task.taskId.compareTo(b.task.taskId);
      return descending ? -result : result;
    });
    return sortedList;
  }
}

extension IterableTaskExtension on Iterable<Task>? {
  List<Task> sortByTaskId({required bool descending}) {
    if (this == null || this!.isEmpty) {
      return [];
    }
    List<Task> sortedList = this!.toList();
    sortedList.sort((a, b) {
      int result = a.taskId.compareTo(b.taskId);
      return descending ? -result : result;
    });
    return sortedList;
  }
}
