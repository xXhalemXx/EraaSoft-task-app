part of 'home_cubit.dart';

enum CurrentHomeState { initial, loading, loaded }

class HomeState extends Equatable {
  // to control filters in home page
  final String selectedItem;
  final bool isDropDownOpen;
  // to show or hide tasks in specific category
  final bool showTasksInSpecificCategory;
  // selected category data
  final String categoryHeader;
  // list of tasks that show in home
  final List<TaskSyncStatus> tasksWithSyncBool;
  // to control loading states
  final CurrentHomeState currentHomeState;
  // number of tasks
  final TasksTypeCount tasksTypeCount;
  // list of tasks that show in specific category
  final List<TaskSyncStatus> tasksInSpecificCategory;

  const HomeState({
    required this.selectedItem,
    required this.isDropDownOpen,
    required this.showTasksInSpecificCategory,
    required this.categoryHeader,
    required this.tasksWithSyncBool,
    required this.currentHomeState,
    required this.tasksTypeCount,
    required this.tasksInSpecificCategory,
  });

  factory HomeState.initial() {
    return HomeState(
      selectedItem: AppStrings.newTasks,
      isDropDownOpen: false,
      showTasksInSpecificCategory: false,
      categoryHeader: '',
      tasksWithSyncBool: const [],
      currentHomeState: CurrentHomeState.initial,
      tasksTypeCount: TasksTypeCount(),
      tasksInSpecificCategory: const [],
    );
  }

  HomeState copyWith({
    String? selectedItem,
    bool? isDropDownOpen,
    bool? showTasksInSpecificCategory,
    String? categoryHeader,
    List<TaskSyncStatus>? tasksWithSyncBool,
    CurrentHomeState? currentHomeState,
    TasksTypeCount? tasksTypeCount,
    List<TaskSyncStatus>? tasksInSpecificCategory,
  }) {
    return HomeState(
      selectedItem: selectedItem ?? this.selectedItem,
      isDropDownOpen: isDropDownOpen ?? this.isDropDownOpen,
      showTasksInSpecificCategory:
          showTasksInSpecificCategory ?? this.showTasksInSpecificCategory,
      categoryHeader: categoryHeader ?? this.categoryHeader,
      tasksWithSyncBool: tasksWithSyncBool ?? this.tasksWithSyncBool,
      currentHomeState: currentHomeState ?? this.currentHomeState,
      tasksTypeCount: tasksTypeCount ?? this.tasksTypeCount,
      tasksInSpecificCategory:
          tasksInSpecificCategory ?? this.tasksInSpecificCategory,
    );
  }

  @override
  List<Object> get props => [
        selectedItem,
        isDropDownOpen,
        showTasksInSpecificCategory,
        categoryHeader,
        tasksWithSyncBool,
        currentHomeState,
        tasksTypeCount,
        tasksInSpecificCategory,
      ];
}
