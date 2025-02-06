import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/home_main_widget.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/tasks_in_specific_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            // home page show all tasks
            HomeMainWidget(state: state),
            // this widget to show all tasks in category that user selected
            Visibility(
              visible: state.showTasksInSpecificCategory,
              child: TasksInSpecificCategory(
                header: state.categoryHeader,
                tasksWithSyncBool: state.tasksInSpecificCategory,
                tasksTypeCount: state.tasksTypeCount,
              ),
            ),
          ],
        );
      },
    );
  }
}
