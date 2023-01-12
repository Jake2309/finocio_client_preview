import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest extends Equatable {
  final String userName;
  final String password;
  LoginRequest({
    required this.userName,
    required this.password,
  });

  LoginRequest copyWith({
    String? userName,
    String? password,
  }) {
    return LoginRequest(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      userName: map['userName'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginRequest(userName: $userName, password: $password)';

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;

  @override
  List<Object> get props => [userName, password];
}
