// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:equatable/equatable.dart';

class FinoPortfolioDetail extends Equatable {
  final int id;
  final int portfolio_id;
  final String symbol;
  final String type;
  final bool is_active;
  final double price;
  final double volume;
  final double change_percent;
  FinoPortfolioDetail({
    required this.id,
    required this.portfolio_id,
    required this.symbol,
    required this.type,
    required this.is_active,
    required this.price,
    required this.volume,
    required this.change_percent,
  });

  @override
  List<Object> get props {
    return [
      id,
      portfolio_id,
      symbol,
      type,
      is_active,
      price,
      volume,
      change_percent,
    ];
  }

  FinoPortfolioDetail copyWith({
    int? id,
    int? portfolio_id,
    String? symbol,
    String? type,
    bool? is_active,
    double? price,
    double? volume,
    double? change_percent,
  }) {
    return FinoPortfolioDetail(
      id: id ?? this.id,
      portfolio_id: portfolio_id ?? this.portfolio_id,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      is_active: is_active ?? this.is_active,
      price: price ?? this.price,
      volume: volume ?? this.volume,
      change_percent: change_percent ?? this.change_percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'portfolio_id': portfolio_id,
      'symbol': symbol,
      'type': type,
      'is_active': is_active,
      'price': price,
      'volume': volume,
      'change_percent': change_percent,
    };
  }

  factory FinoPortfolioDetail.fromMap(Map<String, dynamic> map) {
    return FinoPortfolioDetail(
      id: map['id'] as int,
      portfolio_id: map['portfolio_id'] as int,
      symbol: map['symbol'] as String,
      type: map['type'] as String,
      is_active: map['is_active'] as bool,
      price: map['price'] as double,
      volume: map['volume'] as double,
      change_percent: map['change_percent'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinoPortfolioDetail.fromJson(String source) =>
      FinoPortfolioDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
