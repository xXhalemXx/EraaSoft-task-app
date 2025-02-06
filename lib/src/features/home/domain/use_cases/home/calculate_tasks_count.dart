import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/models/tasks_type_count.dart';

class CalculateTasksCount {
  /// this function to calculate tasks count
  TasksTypeCount call(List<Task> tasks) {
    TasksTypeCount tasksNumbers = TasksTypeCount();
    for (Task task in tasks) {
      // check if task is outdated
      if (task.deliveryDate.isBefore(DateTime.now()) &&
          task.status != HomeCubitStrings.completed) {
        tasksNumbers.outDatedTasksCount += 1;
      } else {
        // if not outdated use task status
        switch (task.status) {
          case HomeCubitStrings.completed:
            tasksNumbers.completedTasksCount += 1;
            break;
          case HomeCubitStrings.inProgress:
            tasksNumbers.inProgressTaskCount += 1;
            break;
          case HomeCubitStrings.pending:
            tasksNumbers.newTasksCount += 1;
            break;
        }
      }
    }
    return tasksNumbers;
  }
}
