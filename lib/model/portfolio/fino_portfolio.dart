// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:stockolio/model/portfolio/fino_porfolio_detail.dart';

class FinoPortfolio extends Equatable {
  final int id;
  final String name;
  final String uid;
  final String watch_list;
  final bool is_default;
  final bool is_anonymous;
  final List<FinoPortfolioDetail> details;

  FinoPortfolio({
    required this.id,
    required this.name,
    required this.uid,
    required this.watch_list,
    required this.is_default,
    required this.is_anonymous,
    required this.details,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      uid,
      watch_list,
      is_default,
      is_anonymous,
      details,
    ];
  }

  FinoPortfolio copyWith({
    int? id,
    String? name,
    String? uid,
    String? watch_list,
    bool? is_default,
    bool? is_anonymous,
    List<FinoPortfolioDetail>? details,
  }) {
    return FinoPortfolio(
      id: id ?? this.id,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      watch_list: watch_list ?? this.watch_list,
      is_default: is_default ?? this.is_default,
      is_anonymous: is_anonymous ?? this.is_anonymous,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'uid': uid,
      'watch_list': watch_list,
      'is_default': is_default,
      'is_anonymous': is_anonymous,
      'details': details.map((x) => x.toMap()).toList(),
    };
  }

  factory FinoPortfolio.fromMap(Map<String, dynamic> map) {
    return FinoPortfolio(
      id: map['id'] as int,
      name: map['name'] as String,
      uid: map['uid'] as String,
      watch_list: map['watch_list'] as String,
      is_default: map['is_default'] as bool,
      is_anonymous: map['is_anonymous'] as bool,
      details: List<FinoPortfolioDetail>.from(
        map['details'].map<FinoPortfolioDetail>(
          (x) => FinoPortfolioDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinoPortfolio.fromJson(String source) =>
      FinoPortfolio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
