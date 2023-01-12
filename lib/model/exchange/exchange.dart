// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ExchangeModel extends Equatable {
  final String code;
  final String name;
  final String curency;
  final DateTime? atoStart;
  final DateTime? atoClose;
  final DateTime? amContinuousStart;
  final DateTime? amContinuousEnd;
  final DateTime? pmContinuousStart;
  final DateTime? pmContinuousEnd;
  final DateTime? atcStart;
  final DateTime? atcClose;
  final double? mktVolume;
  final double? mktCap;
  const ExchangeModel({
    required this.code,
    required this.name,
    required this.curency,
    this.atoStart,
    this.atoClose,
    this.amContinuousStart,
    this.amContinuousEnd,
    this.pmContinuousStart,
    this.pmContinuousEnd,
    this.atcStart,
    this.atcClose,
    this.mktVolume,
    this.mktCap,
  });

  @override
  List<Object> get props {
    return [
      code,
      name,
      curency,
      atoStart!,
      atoClose!,
      amContinuousStart!,
      amContinuousEnd!,
      pmContinuousStart!,
      pmContinuousEnd!,
      atcStart!,
      atcClose!,
      mktVolume!,
      mktCap!,
    ];
  }

  ExchangeModel copyWith({
    String? code,
    String? name,
    String? curency,
    DateTime? atoStart,
    DateTime? atoClose,
    DateTime? amContinuousStart,
    DateTime? amContinuousEnd,
    DateTime? pmContinuousStart,
    DateTime? pmContinuousEnd,
    DateTime? atcStart,
    DateTime? atcClose,
    double? mktVolume,
    double? mktCap,
  }) {
    return ExchangeModel(
      code: code ?? this.code,
      name: name ?? this.name,
      curency: curency ?? this.curency,
      atoStart: atoStart ?? this.atoStart,
      atoClose: atoClose ?? this.atoClose,
      amContinuousStart: amContinuousStart ?? this.amContinuousStart,
      amContinuousEnd: amContinuousEnd ?? this.amContinuousEnd,
      pmContinuousStart: pmContinuousStart ?? this.pmContinuousStart,
      pmContinuousEnd: pmContinuousEnd ?? this.pmContinuousEnd,
      atcStart: atcStart ?? this.atcStart,
      atcClose: atcClose ?? this.atcClose,
      mktVolume: mktVolume ?? this.mktVolume,
      mktCap: mktCap ?? this.mktCap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'curency': curency,
      'atoStart': atoStart!.millisecondsSinceEpoch,
      'atoClose': atoClose!.millisecondsSinceEpoch,
      'amContinuousStart': amContinuousStart!.millisecondsSinceEpoch,
      'amContinuousEnd': amContinuousEnd!.millisecondsSinceEpoch,
      'pmContinuousStart': pmContinuousStart!.millisecondsSinceEpoch,
      'pmContinuousEnd': pmContinuousEnd!.millisecondsSinceEpoch,
      'atcStart': atcStart!.millisecondsSinceEpoch,
      'atcClose': atcClose!.millisecondsSinceEpoch,
      'mktVolume': mktVolume,
      'mktCap': mktCap,
    };
  }

  factory ExchangeModel.fromMap(Map<String, dynamic> map) {
    return ExchangeModel(
      code: map['code'] as String,
      name: map['name'] as String,
      curency: map['curency'] as String,
      atoStart: DateTime.fromMillisecondsSinceEpoch(map['atoStart'] as int),
      atoClose: DateTime.fromMillisecondsSinceEpoch(map['atoClose'] as int),
      amContinuousStart:
          DateTime.fromMillisecondsSinceEpoch(map['amContinuousStart'] as int),
      amContinuousEnd:
          DateTime.fromMillisecondsSinceEpoch(map['amContinuousEnd'] as int),
      pmContinuousStart:
          DateTime.fromMillisecondsSinceEpoch(map['pmContinuousStart'] as int),
      pmContinuousEnd:
          DateTime.fromMillisecondsSinceEpoch(map['pmContinuousEnd'] as int),
      atcStart: DateTime.fromMillisecondsSinceEpoch(map['atcStart'] as int),
      atcClose: DateTime.fromMillisecondsSinceEpoch(map['atcClose'] as int),
      mktVolume: map['mktVolume'] as double,
      mktCap: map['mktCap'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExchangeModel.fromJson(String source) =>
      ExchangeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
