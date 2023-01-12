// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CandleSearchRequest extends Equatable {
  final String symbol;
  final String securities_type;
  final String search_interval;
  final int limit;
  CandleSearchRequest({
    required this.symbol,
    required this.securities_type,
    required this.search_interval,
    required this.limit,
  });

  factory CandleSearchRequest.fromJson(Map<dynamic, dynamic> json) {
    return CandleSearchRequest(
        symbol: json['symbol'].toString(),
        securities_type: json['securities_type'],
        search_interval: json['search_interval'],
        limit: json['limit']);
  }

  Map<String, String> toJson() => {
        'symbol': symbol,
        'securities_type': securities_type,
        'search_interval': search_interval,
        'limit': limit.toString(),
      };

  @override
  List<Object> get props => [symbol, securities_type, search_interval, limit];
}
