import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/hive_database_helper.dart';
import 'package:task_app/src/core/helpers/shared_pref_helper.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/api/auth_response_model.dart';
import 'package:task_app/src/core/models/user_data.dart';
import 'package:task_app/src/core/networking/network_exceptions.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/core/routes/router.dart';
import 'package:task_app/src/core/widgets/custom_error_dialog.dart';
import 'package:task_app/src/features/auth/data/repo/auth_repo.dart';
import 'package:task_app/src/features/home/presentation/cubit/create_task_cubit/create_task_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authRepo,
  }) : super(const AuthState());
  final AuthRepo authRepo;

  //* signup controllers*/
  final TextEditingController signupNameController = TextEditingController();
  final TextEditingController signupPasswordController =
      TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  //* login controllers*/
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// used to register user using api and navigate to login after registration
  Future<void> register() async {
    try {
      // check if all fields valid
      if (signUpFormKey.currentState!.validate()) {
        // change state to loading
        emit(state.copyWith(currentAuthState: CurrentAuthState.loading));
        // call API to register user
        AuthResponseModel response = await authRepo.register(
          name: signupNameController.text,
          email: signupEmailController.text,
          password: signupPasswordController.text,
        );
        // change state to loaded
        emit(state.copyWith(currentAuthState: CurrentAuthState.loaded));
        // check if response is successful
        if (response.error == null) {
          // show that user created and navigate to login screen
          _showSnackBarAndNavigateToLogin(
              context: AppRouter.navigatorKey.currentContext!);
        } else {
          // show error dialog
          showDialog(
            barrierDismissible: false,
            context: AppRouter.navigatorKey.currentContext!,
            builder: (_) => CustomErrorDialog(
              content: response.error!,
            ),
          );
        }
      }
    } catch (e) {
      // change state to loaded
      emit(state.copyWith(currentAuthState: CurrentAuthState.loaded));
      // show error dialog
      showDialog(
        barrierDismissible: false,
        context: AppRouter.navigatorKey.currentContext!,
        builder: (_) => CustomErrorDialog(
          content: NetworkExceptions.getDioExceptionMessage(e),
        ),
      );
    }
  }

  void _showSnackBarAndNavigateToLogin({required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.userCreated),
      ),
    );
    //fill user email filed with the registered email
    loginEmailController.text = signupEmailController.text;
    // reset signup fields
    signupNameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    // navigate to login page
    Navigator.pop(context);
  }

  /// using api to login user and store user data in shared prf and secured flutter storage
  Future<void> login() async {
    try {
      // check if all fields valid
      if (loginFormKey.currentState!.validate()) {
        // change state to loading
        emit(state.copyWith(currentAuthState: CurrentAuthState.loading));
        // call API to login user
        AuthResponseModel response = await authRepo.login(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        );
        // check if response is successful
        if (response.error == null) {
          //reset login fields
          loginEmailController.clear();
          loginPasswordController.clear();

          // store user data into user data model & local Storage
          await _storeUserData(
            name: response.data.user.name,
            email: response.data.user.email,
            token: response.data.token,
          );
          //update dio header after getting token
          await _assignNewDioHeader();

          // call get all tasks to get tasks from api or database
          await getIt<HomeCubit>().getAllTasks();

          // navigate to main screen
          await Navigator.pushReplacementNamed(
              AppRouter.navigatorKey.currentContext!, RoutesNames.dashboard);
          // change state to loaded
          emit(state.copyWith(currentAuthState: CurrentAuthState.loaded));
        } else {
          // show error dialog
          showDialog(
            barrierDismissible: false,
            context: AppRouter.navigatorKey.currentContext!,
            builder: (_) => CustomErrorDialog(
              content: response.error!,
            ),
          );
        }
      }
    } catch (e) {
      // change state to loaded
      emit(state.copyWith(currentAuthState: CurrentAuthState.loaded));
      // show error dialog
      showDialog(
        barrierDismissible: false,
        context: AppRouter.navigatorKey.currentContext!,
        builder: (_) => CustomErrorDialog(
          content: NetworkExceptions.getDioExceptionMessage(e),
        ),
      );
    }
  }

  /// store user data in shared pref
  Future<void> _storeUserData(
      {required String name,
      required String email,
      required String token}) async {
    await SharedPrefHelper.setData(key: DataBaseKeys.userName, value: name);
    await SharedPrefHelper.setData(key: DataBaseKeys.userEmail, value: email);
    await SharedPrefHelper.setSecuredString(
        key: DataBaseKeys.token, value: token);
    UserData.email = email;
    UserData.name = name;
    UserData.token = token;
  }

  /// update dio header
  Future<void> _assignNewDioHeader() async {
    getIt<Dio>().options.headers = {
      ApiConstant.authorization: '${ApiConstant.bearer} ${UserData.token}'
    };
  }
}
