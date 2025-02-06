import 'package:flutter/material.dart';
import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/routes/routes.dart';
import 'task_app.dart';

Future<void> main() async {
  //makes sure that first frame is initialized before removing the splash screen
  WidgetsFlutterBinding.ensureInitialized();

  // get initial route
  String initialRoute = await AppRouter.getInitialRoute();

  // setup local data base Hive
  await HiveDatabaseHelper.init();

  // Here we are calling the Dependency Injection
  await setupGetIt();

  // This is the main app
  runApp(TaskApp(
    initialRoute: initialRoute,
  ));
}
