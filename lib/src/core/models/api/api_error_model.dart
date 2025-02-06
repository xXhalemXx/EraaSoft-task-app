class ApiErrorModel {
  final List<dynamic> data;
  final String error;
  final String message;
  final ErrorDetails errors;

  ApiErrorModel({
    required this.data,
    required this.error,
    required this.message,
    required this.errors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      data: List<dynamic>.from(json['data']),
      error: json['error'],
      message: json['message'],
      errors: ErrorDetails.fromJson(json['errors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'error': error,
      'message': message,
      'errors': errors.toJson(),
    };
  }
}

class ErrorDetails {
  final List<String>? emailErrors;
  final List<String>? passwordErrors;
  final List<String>? nameErrors;

  ErrorDetails({
    required this.emailErrors,
    required this.passwordErrors,
    required this.nameErrors,
  });

  factory ErrorDetails.fromJson(Map<String, dynamic> json) {
    return ErrorDetails(
      emailErrors:
          json['email'] == null ? [] : List<String>.from(json['email']),
      passwordErrors:
          json['password'] == null ? [] : List<String>.from(json['password']),
      nameErrors: json['name'] == null ? [] : List<String>.from(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': emailErrors,
      'password': passwordErrors,
      'name': nameErrors,
    };
  }
}
