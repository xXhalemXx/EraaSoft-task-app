import 'package:flutter/material.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/widgets/empty_app_bar.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/pages/dashboard_pages/create_task_page.dart';
import 'package:task_app/src/features/home/presentation/pages/dashboard_pages/home_page.dart';
import 'package:task_app/src/features/home/presentation/pages/dashboard_pages/profile_page.dart';
import 'package:task_app/src/features/home/presentation/widgets/common/custom_bottom_navigation_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // this empty app bar used to override status bar color and status bar icons as provided in figma design
      appBar: const EmptyAppBar(),
      // to control back button actions
      body: PopScope(
        onPopInvokedWithResult: (didPop, __) => getIt<DashboardCubit>()
            .backButtonPressed(didPop: didPop, context: context),
        canPop: false,
        // prevent data show under status bar
        child: SafeArea(
          // using stack to show overflow bottom nav bar
          child: Stack(
            children: [
              //body of dashboard screen
              PageView(
                controller: getIt<DashboardCubit>().pageController,
                children: const [
                  HomePage(),
                  CreateTaskPage(),
                  ProfilePage(),
                ],
                onPageChanged: (value) =>
                    getIt<DashboardCubit>().changePage(value),
              ),
              // AppBottomNavigationBar
              const CustomBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}
