import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/helpers/logout_services.dart';
import 'package:task_app/src/core/models/user_data.dart';
import 'package:task_app/src/core/networking/network_exceptions.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/core/routes/router.dart';
import 'package:task_app/src/features/home/data/home_repo.dart';

import 'package:task_app/src/features/home/presentation/widgets/common/success_dialog.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.homeRepo}) : super(const ProfileState());
  final HomeRepo homeRepo;
  //* profile controllers*/
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  void setUserOldData() {
    nameController.text = UserData.name ?? '';
    emailController.text = UserData.email ?? '';
  }

  void updateProfile() async {
    try {
      // check if all fields valid
      if (profileFormKey.currentState!.validate()) {
        // change state to loading
        emit(state.copyWith(currentUpdateState: CurrentUpdateState.loading));
        //todo ask back end to add update user data
        // simulate api call
        await Future.delayed(const Duration(seconds: 1));
        //show success dialog
        showDialog(
          barrierDismissible: false,
          context: AppRouter.navigatorKey.currentContext!,
          builder: (_) => const SuccessDialog(
            text: AppStrings.userDataUpdatedSuccessfully,
          ),
        );
        // change state to loaded
        emit(state.copyWith(currentUpdateState: CurrentUpdateState.loaded));
      }
    } catch (e) {
      // change state to loaded
      emit(state.copyWith(currentUpdateState: CurrentUpdateState.loaded));
      // check if token is expired if yes logout user and navigate to login
      // else show error dialog pending on error
      NetworkExceptions.getErrorMessageWithTokenCheck(e);
    }
  }

  void logout() async {
    try {
      // change state to loading
      emit(state.copyWith(currentLogoutState: CurrentLogoutState.loading));
      // call api to logout
      await homeRepo.logout();
      // clear user data
      LogoutServices.clearUserDataToLogout();
      // change state to loaded
      emit(state.copyWith(currentLogoutState: CurrentLogoutState.loaded));
      // navigate to login page
      Navigator.of(AppRouter.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(
              RoutesNames.login, (Route<dynamic> route) => false);
    } catch (e) {
      // change state to loaded
      emit(state.copyWith(currentLogoutState: CurrentLogoutState.loaded));

      // check if token is expired if yes logout user and navigate to login
      // else show error dialog pending on error
      NetworkExceptions.getErrorMessageWithTokenCheck(e);
    }
  }
}
