// ignore_for_file: file_names

class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String? avatar;
  final DateTime createdAt;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.avatar,
    required this.createdAt,
  });

  // Convertir un JSON en objet User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Convertir un objet User en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Copier un utilisateur en modifiant certains attributs
  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? avatar,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
