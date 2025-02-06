import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_response_model.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class Task extends HiveObject with EquatableMixin {
  @HiveField(0)
  int taskId;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String status;
  @HiveField(4)
  DateTime deliveryDate;
  @HiveField(5)
  String priority;
  @HiveField(6)
  DateTime createdAt;

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.deliveryDate,
    required this.priority,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      title: json['title'],
      description: json['description'],
      status: json['status'] ?? 'pending',
      deliveryDate: DateTime.parse(json['deliveryDate']),
      priority: json['priority'] ?? 'low',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        deliveryDate,
      ];
}

class Meta {
  int currentPage;
  int lastPage;
  int perPage;
  int numberOfPages;
  int total;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.numberOfPages,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      numberOfPages: json['number_of_pages'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'number_of_pages': numberOfPages,
      'total': total,
    };
  }
}

class TaskResponseModel {
  List<Task> data;
  Meta meta;
  dynamic error;

  TaskResponseModel({
    required this.data,
    required this.meta,
    this.error,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskResponseModel(
      data: (json['data'] as List).map((i) => Task.fromJson(i)).toList(),
      meta: Meta.fromJson(json['meta']),
      error: json['error'],
    );
  }
}
