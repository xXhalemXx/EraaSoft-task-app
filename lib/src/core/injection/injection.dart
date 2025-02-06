import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_app/src/core/networking/api_service.dart';
import 'package:task_app/src/core/networking/dio_factory.dart';
import 'package:task_app/src/features/auth/data/repo/auth_repo.dart';
import 'package:task_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_app/src/features/home/data/home_repo.dart';
import 'package:task_app/src/features/home/domain/use_cases/create_task/add_task_to_server_use_case.dart';
import 'package:task_app/src/features/home/domain/use_cases/create_task/create_task_in_db_or_server_use_case.dart';
import 'package:task_app/src/features/home/domain/use_cases/home/get_tasks_use_case.dart';
import 'package:task_app/src/features/home/domain/use_cases/home/update_task_data_use_case.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImp(dio: getIt()));

  // auth repo
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(apiService: getIt()));

  // home repo

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(apiService: getIt()));

  // home use cases

  getIt.registerLazySingleton<GetTasksUseCase>(
      () => GetTasksUseCase(homeRepo: getIt()));
  getIt.registerLazySingleton<UpdateTaskDataUseCase>(
      () => UpdateTaskDataUseCase(homeRepo: getIt()));

  // create Task use cases
  getIt.registerLazySingleton<CreateTaskInDbOrServerUseCase>(
      () => CreateTaskInDbOrServerUseCase(homeRepo: getIt()));
  getIt.registerLazySingleton<AddTaskToServerUseCase>(
      () => AddTaskToServerUseCase(homeRepo: getIt()));

  // auth cubit
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
        authRepo: getIt(),
      ));
  // Dashboard cubit
  getIt.registerLazySingleton<DashboardCubit>(() => DashboardCubit());
  // home cubit
  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(
      getTasksUseCase: getIt(),
      updateTaskDataUseCase: getIt(),
    ),
  );
  // profile cubit
  getIt.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(homeRepo: getIt()));
  // create task cubit
  getIt.registerLazySingleton<CreateTaskCubit>(() => CreateTaskCubit(
      createTaskInDbOrServerUseCase: getIt(), addTaskToServerUseCase: getIt()));
}
