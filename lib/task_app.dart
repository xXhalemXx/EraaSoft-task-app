import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_themes.dart';
import 'src/core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.defaultTheme,
        initialRoute: initialRoute,
        onGenerateRoute: AppRouter.generate,
      ),
    );
  }
}
