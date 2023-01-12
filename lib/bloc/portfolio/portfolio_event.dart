import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PortfolioEvent extends Equatable {}

class FetchPortfolioData extends PortfolioEvent {
  final bool isUserLoggedIn;
  FetchPortfolioData({required this.isUserLoggedIn});
  @override
  List<Object> get props => [isUserLoggedIn];
}

class SaveProfile extends PortfolioEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class DeleteProfile extends PortfolioEvent {
  final String symbol;

  DeleteProfile({required this.symbol});

  @override
  List<Object> get props => [symbol];
}

class OnUpdatePortfolio extends PortfolioEvent {
  final String name;
  final String watchlist;

  OnUpdatePortfolio(this.name, this.watchlist);

  @override
  List<Object> get props => [name, watchlist];
}

class OnRemoveSymbolFromWatchlist extends PortfolioEvent {
  final List<String> symbols;

  OnRemoveSymbolFromWatchlist({required this.symbols});

  @override
  List<Object> get props => throw UnimplementedError();
}
