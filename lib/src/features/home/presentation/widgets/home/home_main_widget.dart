import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/helpers/extensions.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/pages/loading_pages/home_loading_page.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/horizontal_line.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/no_tasks_yet.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/home_header.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/list_of_tasks.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/recent_tasks_and_filter.dart';
import 'package:task_app/src/features/home/presentation/widgets/home/task_categories.dart';

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({super.key, required this.state});
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: RefreshIndicator(
        color: AppColors.darkBlue,
        backgroundColor: AppColors.white,
        onRefresh: () => getIt<HomeCubit>().getAllTasks(),
        // to make refresh button work
        child: ListView(
          children: [
            verticalSpace(height: 24),
            const HomeHeader(),
            verticalSpace(height: 24),
            state.currentHomeState == CurrentHomeState.loaded
                ? Column(
                    children: [
                      TaskCategories(
                        tasksTypeCount: state.tasksTypeCount,
                      ),
                      verticalSpace(height: 24),
                      const HorizontalLine(),
                      verticalSpace(height: 16),
                      const RecentTasksAndFilter(),
                      verticalSpace(height: 16),
                      state.tasksWithSyncBool.isNullOrEmpty()
                          ? const NoTasksYet()
                          : ListOfTasks(
                              tasksWithSyncBool: state.tasksWithSyncBool,
                              tasksTypeCount: state.tasksTypeCount,
                            ),
                    ],
                  )
                : const HomeLoadingPage(),
          ],
        ),
      ),
    );
  }
}
