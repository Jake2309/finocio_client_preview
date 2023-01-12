// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MiniTicker extends Equatable {
  final String symbol;
  final double currentPrice;
  final double change;
  final double changePercent;
  MiniTicker({
    required this.symbol,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
  });

  factory MiniTicker.fromJson(String jsonString) {
    var jsonData = jsonDecode(jsonString);
    return MiniTicker(
      symbol: jsonData['symbol'].toString(),
      currentPrice: jsonData['current_price'],
      change: jsonData['change'],
      changePercent: jsonData['change_percent'],
    );
  }

  @override
  List<Object> get props => [symbol, currentPrice, change, changePercent];
}
