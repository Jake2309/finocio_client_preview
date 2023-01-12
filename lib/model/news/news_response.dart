// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:stockolio/model/news/news.dart';

class NewsResponse {
  String? status;
  int? totalResult;
  List<News>? results;
  int? nextPage;
  NewsResponse({
    this.status,
    this.totalResult,
    this.results,
    this.nextPage,
  });

  NewsResponse copyWith({
    String? status,
    int? totalResult,
    List<News>? result,
    int? nextPage,
  }) {
    return NewsResponse(
      status: status ?? this.status,
      totalResult: totalResult ?? this.totalResult,
      results: result ?? this.results,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResult': totalResult,
      'result':
          results != null ? results!.map((x) => x.toMap()).toList() : null,
      'nextPage': nextPage,
    };
  }

  factory NewsResponse.fromMap(Map<String, dynamic> map) {
    return NewsResponse(
      status: map['status'] != null ? map['status'] as String : null,
      totalResult:
          map['totalResult'] != null ? map['totalResult'] as int : null,
      results: map['results'] != null
          ? List<News>.from(
              map['result'].map<News?>(
                (x) => News.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      nextPage: map['nextPage'] != null ? map['nextPage'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsResponse.fromJson(String source) =>
      NewsResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsResponse(status: $status, totalResult: $totalResult, result: $results, nextPage: $nextPage)';
  }

  @override
  bool operator ==(covariant NewsResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.totalResult == totalResult &&
        listEquals(other.results, results) &&
        other.nextPage == nextPage;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        totalResult.hashCode ^
        results.hashCode ^
        nextPage.hashCode;
  }
}
