import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/helpers/shared_pref_helper.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/user_data.dart';
import 'package:task_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';

class LogoutServices {
  static void clearUserDataToLogout() {
    // reset user data
    UserData.name = null;
    UserData.email = null;
    UserData.token = null;
    // clear shared pref
    SharedPrefHelper.clearAllData();
    SharedPrefHelper.clearAllSecuredData();
    // Reset all lazy singletons
    getIt.resetLazySingleton<AuthCubit>();
    getIt.resetLazySingleton<DashboardCubit>();
    getIt.resetLazySingleton<HomeCubit>();
    getIt.resetLazySingleton<CreateTaskCubit>();
    getIt.resetLazySingleton<ProfileCubit>();
    // clear hive database
    HiveDatabaseHelper.deleteAllTasks();
    // stop  connection stream
    getIt<DashboardCubit>().stopConnectivityListener();
  }
}
