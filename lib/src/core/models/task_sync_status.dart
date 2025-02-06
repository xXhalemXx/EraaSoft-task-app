// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:task_app/src/core/models/api/task_response_model.dart';

part 'task_sync_status.g.dart';

@HiveType(typeId: 1)
class TaskSyncStatus extends HiveObject with EquatableMixin {
  @HiveField(0)
  Task task;
  @HiveField(1)
  bool needUpload;
  @HiveField(2)
  bool needUpdate;

  TaskSyncStatus({
    required this.task,
    required this.needUpload,
    required this.needUpdate,
  });

  @override
  List<Object?> get props => [task, needUpload, needUpdate];
}
