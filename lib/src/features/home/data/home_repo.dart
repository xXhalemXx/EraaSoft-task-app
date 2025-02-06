import 'package:task_app/src/core/models/api/create_task_model.dart';
import 'package:task_app/src/core/models/api/filters_model.dart';
import 'package:task_app/src/core/models/api/single_task_model.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/networking/api_service.dart';

class HomeRepo {
  HomeRepo({required this.apiService});
  final ApiService apiService;

  Future<TaskResponseModel> getUserTasks() async {
    return await apiService.getUserTasks();
  }

  Future<TaskResponseModel> filterTasks({
    required FiltersModel filters,
  }) async {
    return await apiService.filterTasks(
      filters: filters,
    );
  }

  Future<SingleTaskModel> createTask({
    required CreateTaskModel task,
  }) async {
    return await apiService.createTask(task: task);
  }

  Future<SingleTaskModel> updateTask({
    required Task task,
    String? status,
  }) async {
    return await apiService.updateTask(
      task: task,
      status: status,
    );
  }

  Future<void> logout() async {
    await apiService.logout();
  }
}
