// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String userName;
  final String password;
  final String confirmPassword;
  RegisterRequest({
    required this.userName,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [userName, password, confirmPassword];

  RegisterRequest copyWith({
    String? userName,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterRequest(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      userName: map['userName'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
