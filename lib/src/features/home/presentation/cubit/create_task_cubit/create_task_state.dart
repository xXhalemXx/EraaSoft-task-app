part of 'create_task_cubit.dart';

enum CurrentCreateTaskState { initial, loading, loaded }

class CreateTaskState extends Equatable {
  const CreateTaskState({
    this.currentCreateTaskState = CurrentCreateTaskState.initial,
  });
  final CurrentCreateTaskState currentCreateTaskState;

  CreateTaskState copyWith({
    CurrentCreateTaskState? currentCreateTaskState,
  }) {
    return CreateTaskState(
      currentCreateTaskState:
          currentCreateTaskState ?? this.currentCreateTaskState,
    );
  }

  @override
  List<Object> get props => [
        currentCreateTaskState,
      ];
}
