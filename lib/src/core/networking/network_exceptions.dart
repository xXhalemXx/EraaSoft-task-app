import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/constants/app_text_styles.dart';
import 'package:task_app/src/core/helpers/logout_services.dart';
import 'package:task_app/src/core/models/api/api_error_model.dart';
import 'package:task_app/src/core/models/user_data.dart';
import 'package:task_app/src/core/routes/names.dart';
import 'package:task_app/src/core/routes/router.dart';
import 'package:task_app/src/core/widgets/custom_error_dialog.dart';

abstract class NetworkExceptions {
  // task exception object and return NetworkExceptions message
  static String getDioExceptionMessage(error) {
    if (error is DioException) {
      if (error.error is SocketException) {
        return 'There is no internet connection';
      }
      switch (error.type) {
        case DioExceptionType.badCertificate:
          return 'Bad Certificate';
        case DioExceptionType.badResponse:
          return NetworkExceptions.handleResponse(error.response);
        case DioExceptionType.connectionError:
          return 'There is no internet connection';
        case DioExceptionType.cancel:
          return 'The request was cancelled by the user';
        case DioExceptionType.connectionTimeout:
          return 'request time out check your internet connection';
        case DioExceptionType.unknown:
          return 'unknown error';
        case DioExceptionType.receiveTimeout:
          return 'The server did not respond in time';
        case DioExceptionType.sendTimeout:
          return 'The request could not be sent in time';
      }
    } else if (error is SocketException) {
      return 'noInternetConnection';
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return 'unable to process';
      } else {
        return 'unexpected error';
      }
    }
  }

  static String handleResponse(Response? response) {
    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
        return 'Bad Request -- Your request is invalid.';
      case 401:
        return 'Invalid Credentials';
      case 403:
        return 'Forbidden -- You have reached your daily quota, the next reset is at 00:00 UTC.';
      case 404:
        return 'Not Found -- The specified endpoint could not be found.';
      case 422:
        ApiErrorModel errorModel = ApiErrorModel.fromJson(response?.data ?? {});
        return errorModel.error;
      case 429:
        return 'Too Many Requests -- You have made more requests per second than you are allowed.';
      case 500:
        return 'Internal Server Error -- We had a problem with our server. Try again later.';
      case 503:
        return 'Service Unavailable -- We\'re temporarily offline for maintenance. Please try again later.';
      default:
        return "unexpected error";
    }
  }

  static getErrorMessageWithTokenCheck(error) {
    if (error is DioException) {
      if ((error.response?.statusCode == 401 ||
              error.response?.statusCode == 500) &&
          UserData.token != null) {
        tokenExpiredAndLogout();
        return;
      }
    }
    // show error dialog
    showDialog(
      barrierDismissible: false,
      context: AppRouter.navigatorKey.currentContext!,
      builder: (_) => CustomErrorDialog(
        content: getDioExceptionMessage(error),
      ),
    );
  }

  /// this function logout user if token is expired or invalid
  /// this Function used only with methods that use user token
  static tokenExpiredAndLogout() {
    // clear user data
    LogoutServices.clearUserDataToLogout();
    // show error dialog
    showDialog(
      barrierDismissible: false,
      context: AppRouter.navigatorKey.currentContext!,
      builder: (_) => CustomErrorDialog(
        content: "Your session is expired, please login again",
        buttonText: AppStrings.login,
        onTap: () {
          Navigator.pop(AppRouter.navigatorKey.currentContext!);
          Navigator.of(AppRouter.navigatorKey.currentContext!)
              .pushNamedAndRemoveUntil(
                  RoutesNames.login, (Route<dynamic> route) => false);
        },
      ),
    );
  }
}
