class AuthResponseModel {
  final Data data;
  final String? error;

  AuthResponseModel({required this.data, this.error});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      data: Data.fromJson(json['data']),
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'error': error,
    };
  }
}

class Data {
  final String token;
  final User user;

  Data({required this.token, required this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final String name;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  User({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
