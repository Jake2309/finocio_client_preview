// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CompanyInfo extends Equatable {
  final String? code;
  final String? name;
  final String? ceo;
  final String? logo;
  final String? desciptions;
  CompanyInfo({
    this.code,
    this.name,
    this.ceo,
    this.logo,
    this.desciptions,
  });

  @override
  List<Object> get props {
    return [
      code!,
      name!,
      ceo!,
      logo!,
      desciptions!,
    ];
  }

  CompanyInfo copyWith({
    String? code,
    String? name,
    String? ceo,
    String? logo,
    String? desciptions,
  }) {
    return CompanyInfo(
      code: code ?? this.code,
      name: name ?? this.name,
      ceo: ceo ?? this.ceo,
      logo: logo ?? this.logo,
      desciptions: desciptions ?? this.desciptions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'ceo': ceo,
      'logo': logo,
      'desciptions': desciptions,
    };
  }

  factory CompanyInfo.fromMap(Map<String, dynamic> map) {
    return CompanyInfo(
      code: map['code'] as String,
      name: map['name'] as String,
      ceo: map['ceo'] as String,
      logo: map['logo'] as String,
      desciptions: map['desciptions'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyInfo.fromJson(String source) =>
      CompanyInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
