// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MarketSearchResponse extends Equatable {
  final String symbol;
  final String name;
  final String logo;
  MarketSearchResponse({
    required this.symbol,
    required this.name,
    required this.logo,
  });

  factory MarketSearchResponse.fromJson(Map<dynamic, dynamic> json) {
    return MarketSearchResponse(
      symbol: json['symbol'].toString(),
      name: json['name'],
      logo: json['logo_data'],
    );
  }

  @override
  List<Object> get props => [symbol, name, logo];
}
