import 'dart:ffi';

import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/model/portfolio/fino_portfolio.dart';
import 'package:stockolio/model/portfolio/update_portfolio_request.dart';

abstract class IPortfolioRepo {
  Future<Result<List<FinoPortfolio>>> getWatchLists();
  Future<bool> saveToWatchList(String symbol);
  Future<Result> updateWatchlist(UpdatePortfolioRequest request);
  Future<Result> getPortfolio(Int64 id);
}
