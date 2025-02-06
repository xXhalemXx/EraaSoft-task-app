import 'package:task_app/src/core/helpers/connectivity_checker.dart';
import 'package:task_app/src/core/helpers/extensions.dart';
import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/features/home/data/home_repo.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';

class GetTasksUseCase {
  HomeRepo homeRepo;

  GetTasksUseCase({
    required this.homeRepo,
  });
  // get tasks from server and sync database
  Future<List<TaskSyncStatus>> call() async {
    List<TaskSyncStatus> tasksWithSyncBool;
    if (await ConnectivityChecker.isConnected()) {
      TaskResponseModel response = await homeRepo.getUserTasks();
      // check if server contain new tasks and update local database with new tasks
      // and check if local database contain new tasks and update server
      List<Task> tasks = await _syncDatabaseAndServer(response.data);
      tasksWithSyncBool = List.generate(
        tasks.length,
        (i) => TaskSyncStatus(
            task: tasks[i], needUpload: false, needUpdate: false),
      );
    } else {
      tasksWithSyncBool = await HiveDatabaseHelper.getLocalDatabaseTasks();
    }
    return tasksWithSyncBool;
  }

  Future<List<Task>> _syncDatabaseAndServer(List<Task> serverTasks) async {
    bool needUpdateDatabase = false;
    bool thereNewTasksAddToServer = false;
    // get tasks from local database in ascending order
    // because we will add tasks from local database in server if theres one new
    // so we need to get them in ascending order to be same order that user added them
    List<TaskSyncStatus> storedTasks =
        await HiveDatabaseHelper.getLocalDatabaseTasks(descending: false);
    // check if server contain new tasks need to add it to local database
    for (Task task in serverTasks) {
      if (!storedTasks.isTaskInTheList(task)) {
        needUpdateDatabase = true;
        break;
      }
    }
    // check if local database contain new tasks and added to server
    for (TaskSyncStatus localTask in storedTasks) {
      // if task in local database and need to upload or need to update
      if (localTask.needUpload) {
        // task in local database and in server database
        if (serverTasks.isTaskInTheList(localTask.task)) {
          // mean that task in local database and in server database but need to update it
          if (localTask.needUpdate) {
            await homeRepo.updateTask(
              task: localTask.task,
              status: localTask.task.status,
            );
          }
        } else {
          // mean task in local database and not in server database and need update
          // so we upload it then update it
          if (localTask.needUpdate) {
            await getIt<CreateTaskCubit>()
                .addTaskToServer(task: localTask.task);
            await homeRepo.updateTask(
              task: localTask.task,
              status: localTask.task.status,
            );
          } else {
            // mean task in local database and not in server database so we upload it
            await getIt<CreateTaskCubit>()
                .addTaskToServer(task: localTask.task);
          }
        }
        thereNewTasksAddToServer = true;
        needUpdateDatabase = true;
      }
    }
    // if server contain tasks not exists in local database we update it with
    // latest version from server
    if (needUpdateDatabase) {
      // if we uploaded tasks from database we call all tasks from sever then
      // we update local database because maybe user added tasks from another
      // devise so we make sure we have latest version
      if (thereNewTasksAddToServer) {
        TaskResponseModel response = await homeRepo.getUserTasks();
        serverTasks = response.data;
      }
      _updateDatabase(serverTasks);
    }

    return serverTasks;
  }

  /// this function reset local database and fill it with last version from server
  Future<void> _updateDatabase(List<Task> tasks) async {
    await HiveDatabaseHelper.deleteAllTasks();
    for (Task task in tasks) {
      await HiveDatabaseHelper.addLocalDatabaseTask(
          TaskSyncStatus(task: task, needUpload: false, needUpdate: false));
    }
  }
}
