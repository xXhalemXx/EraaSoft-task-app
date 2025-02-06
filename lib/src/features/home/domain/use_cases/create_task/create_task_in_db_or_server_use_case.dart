import 'package:intl/intl.dart';
import 'package:task_app/src/core/helpers/connectivity_checker.dart';
import 'package:task_app/src/core/helpers/extensions.dart';
import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/api/create_task_model.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/models/task_sync_status.dart';
import 'package:task_app/src/features/home/data/home_repo.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';

class CreateTaskInDbOrServerUseCase {
  final HomeRepo homeRepo;

  CreateTaskInDbOrServerUseCase({required this.homeRepo});

  /// this function check if task already exists or not
  /// if not exists add task to server or add task to local database
  /// depending on internet connection
  Future<bool> call({
    required DateTime selectedDateTime,
    required String taskName,
    required String note,
  }) async {
    // create task model
    CreateTaskModel task = CreateTaskModel(
      title: taskName,
      description: note,
      deliveryDate: DateFormat('yyyy-MM-dd').format(selectedDateTime),
    );

    if (getIt<HomeCubit>()
        .state
        .tasksWithSyncBool
        .isCreatedTaskInTheList(task)) {
      return true;
    } else {
      if (await ConnectivityChecker.isConnected()) {
        //call api to create task
        await homeRepo.createTask(task: task);
      } else {
        // get last task id from local database
        List<Task> tasks = await HiveDatabaseHelper.getTasks();
        //  add task to local data base
        await HiveDatabaseHelper.addLocalDatabaseTask(
          TaskSyncStatus(
            needUpload: true,
            needUpdate: false,
            task: Task(
              taskId: tasks[0].taskId + 1,
              title: task.title,
              description: task.description,
              status: 'pending',
              deliveryDate: DateTime.parse(task.deliveryDate),
              priority: 'low',
              createdAt: DateTime.now(),
            ),
          ),
        );
      }
      return false;
    }
  }
}
