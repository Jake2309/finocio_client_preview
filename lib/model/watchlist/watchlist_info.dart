// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class WatchlistInfoModel extends Equatable {
  final String code;
  final String name;
  final String exchangeCode;
  final double price;
  final double changeAmount;
  final double changePercent;
  WatchlistInfoModel({
    required this.code,
    required this.name,
    required this.exchangeCode,
    required this.price,
    required this.changeAmount,
    required this.changePercent,
  });

  factory WatchlistInfoModel.fromJson(Map<String, dynamic> json) {
    return WatchlistInfoModel(
      code: json['code'],
      name: json['name'],
      exchangeCode: json['exchangeCode'],
      price: json['price'],
      changePercent: json['changePercent'],
      changeAmount: json['changeAmount'],
    );
  }

  @override
  List<Object> get props {
    return [
      code,
      name,
      exchangeCode,
      price,
      changeAmount,
      changePercent,
    ];
  }
}
