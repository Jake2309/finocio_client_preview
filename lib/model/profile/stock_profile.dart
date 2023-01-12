import 'package:meta/meta.dart';
import 'package:stockolio/model/market/stock_chart.dart';
import 'package:stockolio/model/market/stock_info.dart';
import 'package:stockolio/model/market/stock_quote.dart';

class StockProfile {
  final StockInfo stockInfo;
  final StockQuote stockQuote;
  final List<StockChart> stockCharts;

  StockProfile({
    required this.stockInfo,
    required this.stockQuote,
    required this.stockCharts,
  });
}
