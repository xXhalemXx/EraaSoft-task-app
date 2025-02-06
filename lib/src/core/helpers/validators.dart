import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/injection/injection.dart';
import 'package:task_app/src/core/models/user_data.dart';
import 'package:task_app/src/features/home/presentation/cubit/profile_cubit/profile_cubit.dart';

class Validators {
  static String? nameValidator(String? value) {
    final validCharacters = RegExp(r'[a-zA-Z0-9._]');
    if (value == null || value.isEmpty || value == '') {
      return AppStrings.fillField;
    } else if (!validCharacters.hasMatch(value)) {
      return AppStrings.validName;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    final validCharacters = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || value == '') {
      return AppStrings.fillField;
    } else if (!validCharacters.hasMatch(value)) {
      return AppStrings.validEmail;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return AppStrings.fillField;
    } else if (value.length < 8) {
      return AppStrings.validPassword;
    }
    return null;
  }

  static String? noneEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fillField;
    }
    return null;
  }

  /// this function same as name validator but also check if the name is the same
  /// as the current name and the email is the same as the current email if both
  /// are true return enter new name
  static String? nameUpdateValidator(String? value) {
    final validCharacters = RegExp(r'[a-zA-Z0-9._]');
    if (value == null || value.isEmpty || value == '') {
      return AppStrings.fillField;
    } else if (value == UserData.name &&
        UserData.email == getIt<ProfileCubit>().emailController.text) {
      return AppStrings.enterNewName;
    } else if (!validCharacters.hasMatch(value)) {
      return AppStrings.validName;
    }
    return null;
  }

  /// this function same as email validator but also check if the email is the same
  /// as the current email and the name is the same as the current name if both
  /// are true return enter new name
  static String? emailUpdateValidator(String? value) {
    final validCharacters = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || value == '') {
      return AppStrings.fillField;
    } else if (!validCharacters.hasMatch(value)) {
      return AppStrings.validEmail;
    } else if (value == UserData.email &&
        UserData.name == getIt<ProfileCubit>().nameController.text) {
      return AppStrings.enterNewEmail;
    }
    return null;
  }

  // static String? conformPasswordValidator(String? firstPass, String? secondPass) {
  //   if (secondPass == null || secondPass.isEmpty || secondPass == '') {
  //     return 'You need to fill this field';
  //   } else {
  //     if (firstPass != secondPass) {
  //       return 'passwords do not match';
  //     } else {
  //       return null;
  //     }
  //   }
  // }
}
