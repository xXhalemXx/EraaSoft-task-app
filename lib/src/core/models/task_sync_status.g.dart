// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_sync_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskSyncStatusAdapter extends TypeAdapter<TaskSyncStatus> {
  @override
  final int typeId = 1;

  @override
  TaskSyncStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskSyncStatus(
      task: fields[0] as Task,
      needUpload: fields[1] as bool,
      needUpdate: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskSyncStatus obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.needUpload)
      ..writeByte(2)
      ..write(obj.needUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskSyncStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
