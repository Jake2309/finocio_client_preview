import 'package:equatable/equatable.dart';

abstract class MarketEvent extends Equatable {}

class MarketStarted extends MarketEvent {
  @override
  List<Object> get props => [];
}

// Load by active tab
class MarketTabChanged extends MarketEvent {
  final String currentTab;

  MarketTabChanged({required this.currentTab});

  @override
  List<Object> get props => [currentTab];
}

// Load data by market name
class FetchMarketData extends MarketEvent {
  final String exchangeName;

  FetchMarketData({required this.exchangeName});

  @override
  List<Object> get props => [exchangeName];
}

class MarketPriceIncremented extends MarketEvent {
  @override
  List<Object> get props => [];
}

class MarketPriceDecremented extends MarketEvent {
  @override
  List<Object> get props => [];
}

class SymbolSearch extends MarketEvent {
  final String symbol;
  SymbolSearch({required this.symbol});
  @override
  List<Object> get props => [symbol];
}
