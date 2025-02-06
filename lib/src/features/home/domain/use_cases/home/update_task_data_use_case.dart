import 'package:task_app/src/core/helpers/connectivity_checker.dart';
import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/features/home/data/home_repo.dart';

class UpdateTaskDataUseCase {
  final HomeRepo homeRepo;

  UpdateTaskDataUseCase({required this.homeRepo});

  Future<void> call({
    required Task task,
    String? status,
    String? deliveryDate,
  }) async {
    if (await ConnectivityChecker.isConnected()) {
      await homeRepo.updateTask(
        task: task,
        status: status,
      );
    } else {
      HiveDatabaseHelper.updateLocalDatabaseTask(
          oldTask: task,
          newTask: Task(
            taskId: task.taskId,
            title: task.title,
            description: task.description,
            deliveryDate:
                DateTime.parse(deliveryDate ?? task.deliveryDate.toString()),
            status: status ?? task.status,
            priority: task.priority,
            createdAt: task.createdAt,
          ),
          needUpload: true,
          needUpdate: true);
    }
  }
}
