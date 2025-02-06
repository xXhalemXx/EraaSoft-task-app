import 'package:intl/intl.dart';
import 'package:task_app/src/core/models/api/create_task_model.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/features/home/data/home_repo.dart';

class AddTaskToServerUseCase {
  HomeRepo homeRepo;
  AddTaskToServerUseCase({required this.homeRepo});

  Future<void> call({required Task task}) async {
    // convert task model to create task model
    CreateTaskModel createTaskModel = CreateTaskModel(
      title: task.title,
      description: task.description,
      deliveryDate: DateFormat('yyyy-MM-dd').format(task.deliveryDate),
    );
    //call api to create task
    await homeRepo.createTask(task: createTaskModel);
  }
}
