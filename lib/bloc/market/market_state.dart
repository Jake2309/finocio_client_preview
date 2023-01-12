import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stockolio/model/market/market_search_response.dart';
import 'package:stockolio/model/market/stock_overview.dart';

@immutable
abstract class MarketState extends Equatable {}

class MarketInitial extends MarketState {
  @override
  List<Object> get props => [];
}

class MarketFetchDataInprogress extends MarketState {
  @override
  List<Object> get props => [];
}

class MarketFetchDataSuccess extends MarketState {
  final List<StockOverviewModel> data;
  MarketFetchDataSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class MarketFetchDataFailure extends MarketState {
  final String errMsg;

  MarketFetchDataFailure({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class MarketPriceIncreaseSuccess extends MarketState {
  final double increaseValue, marketPrice;
  MarketPriceIncreaseSuccess(
      {required this.increaseValue, required this.marketPrice});

  @override
  List<Object> get props => [increaseValue, marketPrice];
}

class MarketPriceDecreaseSuccess extends MarketState {
  final double decreaseValue, marketPrice;
  MarketPriceDecreaseSuccess(
      {required this.decreaseValue, required this.marketPrice});
  @override
  List<Object> get props => [decreaseValue, marketPrice];
}

class SymbolSearching extends MarketState {
  @override
  List<Object> get props => [];
}

class SymbolSearchSuccess extends MarketState {
  // Danh sach symbol tra ve
  final List<MarketSearchResponse> response;
  // Luu query search gan nhat de so sanh
  final String lastQuery;
  SymbolSearchSuccess({required this.response, required this.lastQuery});
  @override
  List<Object> get props => [response, lastQuery];
}

class SymbolSearchFailure extends MarketState {
  final String errMsg;
  SymbolSearchFailure({required this.errMsg});
  @override
  List<Object> get props => [errMsg];
}

class MarketHandlerException extends MarketState {
  final String exceptionMsg;
  MarketHandlerException({required this.exceptionMsg});
  @override
  List<Object> get props => [exceptionMsg];
}
