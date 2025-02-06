import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';

class ConnectivityChecker {
  // private constructor to avoid external instantiation
  ConnectivityChecker._();

  static StreamSubscription<List<ConnectivityResult>>? subscription;

  /// check if device is connected or not
  static Future<bool> isConnected() async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  /// function to register stream and depend on connectivity state
  /// update local database if theres new tasks added in server
  /// and update server if local database updated
  static Future<void> registerStream() async {
    subscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) async {
        log('connection method changed');
        // get tasks from server or database depending on internet connection
        // also get all tasks function sync all data between server and local database
        await getIt<HomeCubit>().getAllTasks();
      },
    );
  }

  static void cancelStream() => subscription?.cancel();
}
