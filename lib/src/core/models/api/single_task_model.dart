import 'package:task_app/src/core/models/api/task_response_model.dart';

class SingleTaskModel {
  Task data;
  String? error;

  SingleTaskModel({required this.data, this.error});

  // Method to convert JSON to ApiResponse object
  factory SingleTaskModel.fromJson(Map<String, dynamic> json) {
    return SingleTaskModel(
      data: Task.fromJson(json['data']),
      error: json['error'],
    );
  }
}
