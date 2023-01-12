// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  final String password;
  final String accountType;
  final String email;
  final String mobile;

  const User({
    required this.userName,
    required this.password,
    required this.accountType,
    required this.email,
    required this.mobile,
  });

  @override
  List<Object> get props {
    return [
      userName,
      password,
      accountType,
      email,
      mobile,
    ];
  }

  User copyWith({
    String? userName,
    String? password,
    String? accountType,
    String? email,
    String? mobile,
  }) {
    return User(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      accountType: accountType ?? this.accountType,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
      'accountType': accountType,
      'email': email,
      'mobile': mobile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] as String,
      password: map['password'] as String,
      accountType: map['accountType'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
