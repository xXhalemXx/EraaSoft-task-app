import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_app/src/core/constants/app_colors.dart';
import 'package:task_app/src/core/helpers/spacing.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/horizontal_line.dart';
import 'package:task_app/src/features/home/presentation/widgets/home_loading/list_of_tasks_loading.dart';
import 'package:task_app/src/features/home/presentation/widgets/home_loading/recent_tasks_and_filter_loading.dart';
import 'package:task_app/src/features/home/presentation/widgets/home_loading/task_categories_loading.dart';

class HomeLoadingPage extends StatelessWidget {
  const HomeLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withValues(alpha: 0.3),
      highlightColor: AppColors.lightGray,
      child: Column(
        children: [
          const TaskCategoriesLoading(),
          verticalSpace(height: 24),
          const HorizontalLine(
            color: AppColors.white,
          ),
          verticalSpace(height: 16),
          const RecentTasksAndFilterLoading(),
          verticalSpace(height: 16),
          const ListOfTasksLoading()
        ],
      ),
    );
  }
}
