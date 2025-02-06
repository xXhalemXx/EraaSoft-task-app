import 'package:task_app/src/core/models/api/auth_response_model.dart';
import 'package:task_app/src/core/networking/api_service.dart';

class AuthRepo {
  ApiService apiService;

  AuthRepo({required this.apiService});

  Future<AuthResponseModel> register(
      {required String name, required String email, required String password}) {
    return apiService.register(name: name, email: email, password: password);
  }

  Future<AuthResponseModel> login(
      {required String email, required String password}) {
    return apiService.login(email: email, password: password);
  }
}
