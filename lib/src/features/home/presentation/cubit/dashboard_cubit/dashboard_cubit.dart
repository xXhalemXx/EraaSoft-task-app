import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/core/helpers/connectivity_checker.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());
  final PageController pageController = PageController();

  /// used to navigate throw 3 pages Home , create Task and profile
  void changePage(int index) {
    pageController.jumpToPage(index);
    emit(state.copyWith(currentIndex: index));
  }

  /// used to handel back button actions
  void backButtonPressed(
      {required bool didPop, required BuildContext context}) {
    if (didPop) {
      return;
    }
    if (state.currentIndex == 0) {
      if (getIt<HomeCubit>().state.showTasksInSpecificCategory) {
        getIt<HomeCubit>().closeCategoryViewer();
      } else {
        SystemNavigator.pop();
      }
    } else {
      changePage(0);
    }
  }

  void startConnectivityListener() {
    ConnectivityChecker.registerStream();
  }

  void stopConnectivityListener() {
    ConnectivityChecker.cancelStream();
  }
}
