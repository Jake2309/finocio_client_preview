import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/library/k_chart_library/entity/k_line_entity.dart';
import 'package:stockolio/model/market/candel_search_request.dart';
import 'package:stockolio/model/market/market_search_response.dart';
import 'package:stockolio/model/market/stock_overview.dart';

abstract class IMarketRepo {
  Future<List<StockOverviewModel>> getMarketDataByExchange(String exchangeName);
  Future<Result<List<MarketSearchResponse>>> FilterSymbol(String symbol);
  Future<Result<List<KLineEntity>>> FetchKlineEntities(
      CandleSearchRequest request);
  Future<Result<List<KLineEntity>>> fetchHoubiTradingData(String period);
}
