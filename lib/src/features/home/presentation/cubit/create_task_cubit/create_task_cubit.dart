import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/core/constants/app_strings.dart';

import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/api/task_response_model.dart';
import 'package:task_app/src/core/networking/network_exceptions.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/core/routes/router.dart';
import 'package:task_app/src/core/widgets/custom_error_dialog.dart';
import 'package:task_app/src/features/home/domain/use_cases/create_task/add_task_to_server_use_case.dart';
import 'package:task_app/src/features/home/domain/use_cases/create_task/create_task_in_db_or_server_use_case.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({
    required this.createTaskInDbOrServerUseCase,
    required this.addTaskToServerUseCase,
  }) : super(const CreateTaskState());
  final CreateTaskInDbOrServerUseCase createTaskInDbOrServerUseCase;
  final AddTaskToServerUseCase addTaskToServerUseCase;

  //* create task controllers*/
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> createTaskFormKey = GlobalKey<FormState>();
  final FocusNode noteFocusNode = FocusNode();
  final FocusNode taskNameFocusNode = FocusNode();

  //* selected time*/
  DateTime selectedDateTime = DateTime.now();

  void selectDateAndTime(DateTime dateTime) {
    selectedDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    );
  }

  ///********************************    UI Related   ************************************* */

  void homeButtonPressed({required BuildContext context}) async {
    // update all tasks
    await getIt<HomeCubit>().getAllTasks();
    // pop current page and set index to 0
    Navigator.pop(AppRouter.navigatorKey.currentContext!);
    getIt<DashboardCubit>().changePage(0);
  }

  ///********************************    Logic Related   ************************************* */

  void createNewTask() async {
    try {
      if (createTaskFormKey.currentState!.validate()) {
        //change state to loading
        emit(state.copyWith(
            currentCreateTaskState: CurrentCreateTaskState.loading));

        // check if connected to internet if yes add task to server else add task to local database
        bool taskAlreadyExists = await createTaskInDbOrServerUseCase(
          note: noteController.text,
          selectedDateTime: selectedDateTime,
          taskName: taskNameController.text,
        );
        // remove focus
        noteFocusNode.unfocus();
        taskNameFocusNode.unfocus();
        // change state to loaded
        emit(state.copyWith(
            currentCreateTaskState: CurrentCreateTaskState.loaded));
        _showResultIfTaskAlreadyExists(taskAlreadyExists: taskAlreadyExists);
      }
    } catch (e) {
      // change state to loaded
      emit(state.copyWith(
          currentCreateTaskState: CurrentCreateTaskState.loaded));
      // check if token is expired if yes logout user and navigate to login
      // else show error dialog pending on error
      NetworkExceptions.getErrorMessageWithTokenCheck(e);
    }
  }

  void _showResultIfTaskAlreadyExists({required bool taskAlreadyExists}) {
    if (taskAlreadyExists) {
      // show error dialog
      showDialog(
        barrierDismissible: false,
        context: AppRouter.navigatorKey.currentContext!,
        builder: (_) => const CustomErrorDialog(
          content: AppStrings.thisTaskAlreadyExists,
        ),
      );
    } else {
      // reset create task fields
      taskNameController.clear();
      noteController.clear();
      // show success page
      Navigator.of(AppRouter.navigatorKey.currentContext!)
          .pushNamed(RoutesNames.success);
    }
  }

  Future<void> addTaskToServer({required Task task}) async {
    try {
      await addTaskToServerUseCase(task: task);
    } catch (e) {
      // check if token is expired if yes logout user and navigate to login
      // else show error dialog pending on error
      NetworkExceptions.getErrorMessageWithTokenCheck(e);
    }
  }
}
