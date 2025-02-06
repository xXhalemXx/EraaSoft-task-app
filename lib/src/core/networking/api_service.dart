import 'package:dio/dio.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/models/api/auth_response_model.dart';
import 'package:task_app/src/core/models/api/create_task_model.dart';
import 'package:task_app/src/core/models/api/filters_model.dart';
import 'package:task_app/src/core/models/api/single_task_model.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';

abstract class ApiService {
  Future<AuthResponseModel> register(
      {required String name, required String email, required String password});
  Future<AuthResponseModel> login(
      {required String email, required String password});
  Future<void> logout();
  Future<TaskResponseModel> getUserTasks();
  Future<TaskResponseModel> filterTasks({
    required FiltersModel filters,
  });
  Future<SingleTaskModel> createTask({
    required CreateTaskModel task,
  });
  Future<SingleTaskModel> updateTask({
    required Task task,
    String? status,
  });
}

class ApiServiceImp implements ApiService {
  final Dio dio;

  ApiServiceImp({required this.dio});
  //* authorization methods */
  @override
  Future<AuthResponseModel> register(
      {required String name,
      required String email,
      required String password}) async {
    final Response<Map<String, dynamic>> response = await dio.post(
      ApiConstant.register,
      data: {
        ApiConstant.name: name,
        ApiConstant.email: email,
        ApiConstant.password: password,
        ApiConstant.passwordConfirmation: password,
      },
    );
    return AuthResponseModel.fromJson(response.data ?? {});
  }

  @override
  Future<AuthResponseModel> login(
      {required String email, required String password}) async {
    final Response<Map<String, dynamic>> response = await dio.post(
      ApiConstant.login,
      data: {
        ApiConstant.email: email,
        ApiConstant.password: password,
      },
    );
    return AuthResponseModel.fromJson(response.data ?? {});
  }

  //* task methods */
  @override
  Future<TaskResponseModel> getUserTasks() async {
    final Response<Map<String, dynamic>> response = await dio.get(
      ApiConstant.tasks,
    );
    return TaskResponseModel.fromJson(response.data ?? {});
  }

  @override
  Future<TaskResponseModel> filterTasks({
    required FiltersModel filters,
  }) async {
    final Map<String, dynamic> queryParams = {};

    if (filters.deliveryDate != null) {
      queryParams[ApiConstant.deliveryDate] = filters.deliveryDate;
    }
    if (filters.start != null) {
      queryParams[ApiConstant.start] = filters.start;
    }
    if (filters.end != null) {
      queryParams[ApiConstant.end] = filters.end;
    }
    if (filters.priority != null) {
      queryParams[ApiConstant.priority] = filters.priority;
    }
    if (filters.status != null) {
      queryParams[ApiConstant.status] = filters.status;
    }

    final Response<Map<String, dynamic>> response = await dio.get(
      ApiConstant.tasks,
      queryParameters: queryParams,
    );

    return TaskResponseModel.fromJson(response.data ?? {});
  }

  @override
  Future<SingleTaskModel> createTask({
    required CreateTaskModel task,
  }) async {
    final Response<Map<String, dynamic>> response = await dio.post(
      ApiConstant.tasks,
      data: {
        ApiConstant.title: task.title,
        ApiConstant.description: task.description,
        ApiConstant.deliveryDate: task.deliveryDate,
      },
    );
    return SingleTaskModel.fromJson(response.data ?? {});
  }

  @override
  Future<SingleTaskModel> updateTask({
    required Task task,
    String? status,
  }) async {
    final Response<Map<String, dynamic>> response = await dio.put(
      '${ApiConstant.tasks}/${task.taskId}',
      data: {
        ApiConstant.title: task.title,
        ApiConstant.status: status ?? task.status,
      },
    );
    return SingleTaskModel.fromJson(response.data ?? {});
  }

  @override
  Future<void> logout() async {
    await dio.post(ApiConstant.logout);
  }
}
