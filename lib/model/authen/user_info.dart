// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String name;
  final String gender;
  final String address;
  final String email;
  final String mobile;
  final String homePhone;
  final int age;
  const UserInfo({
    required this.name,
    required this.gender,
    required this.address,
    required this.email,
    required this.mobile,
    required this.homePhone,
    required this.age,
  });

  @override
  List<Object> get props {
    return [
      name,
      gender,
      address,
      email,
      mobile,
      homePhone,
      age,
    ];
  }

  UserInfo copyWith({
    String? name,
    String? gender,
    String? address,
    String? email,
    String? mobile,
    String? homePhone,
    int? age,
  }) {
    return UserInfo(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      homePhone: homePhone ?? this.homePhone,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'gender': gender,
      'address': address,
      'email': email,
      'mobile': mobile,
      'homePhone': homePhone,
      'age': age,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] as String,
      gender: map['gender'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      homePhone: map['homePhone'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
