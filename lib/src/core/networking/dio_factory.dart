import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task_app/src/core/constants/app_strings.dart';
import 'package:task_app/src/core/models/user_data.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    log('current user token ${UserData.token}');
    Duration timeOut = const Duration(seconds: 15);
    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.baseUrl = ApiConstant.baseUrl
        ..options.headers = {
          ApiConstant.accept: ApiConstant.acceptValue,
          ApiConstant.authorization: '${ApiConstant.bearer} ${UserData.token}'
        };

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}

// class DioHelper {
//   static Dio? dio;
//   static init() {
//     dio = Dio(BaseOptions(
//       baseUrl: APIConstant.baseUrl,
//     ));
//     dio!.interceptors.add(PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: false,
//       error: true,
//       compact: true,
//       maxWidth: 90,
//     ));
//   }

//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'authorization': 'Bearer $token',
//     };
//     return await dio!.get(url, queryParameters: query);
//   }

//   static Future<Response> postData({
//     required String url,
//     required dynamic data,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'authorization': 'Bearer $token',
//     };
//     return await dio!.post(url, data: data);
//   }

//   static Future<Response> deleteData({
//     required String url,
//     Map<String, dynamic>? query,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'authorization': 'Bearer $token',
//     };
//     return await dio!.delete(url, queryParameters: query);
//   }
// }
