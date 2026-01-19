import 'dart:convert';

class UserModel {
  int?id;
  String username;
  String name;
  String email;
  String password;
  UserModel({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
  });
  
  UserModel copyWith({
    String? username,
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(username: $username, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.name == name &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}

  