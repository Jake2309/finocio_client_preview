// @immutable
// abstract class PortfolioState extends Equatable {}

// class PortfolioInitial extends PortfolioState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

// class PortfolioLoadFailure extends PortfolioState {
//   final String message;

//   PortfolioLoadFailure({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// class PortfolioLoading extends PortfolioState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

// class PortfolioLoadSuccess extends PortfolioState {
//   final List<FinoPortfolio> watchList;

//   PortfolioLoadSuccess({required this.watchList});

//   @override
//   List<Object> get props => [watchList];
// }

// class UpdatePortfolioSuccess extends PortfolioState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

// class UpdatePortfolioFailure extends PortfolioState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

// class RemoveSymbolSuccess extends PortfolioState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

// class RemoveSymbolFailure extends PortfolioState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/model/portfolio/fino_portfolio.dart';

class PortfolioState {
  final String message;
  final List<FinoPortfolio>? watchList;
  BlocStateStatus status;

  PortfolioState(
      {this.message = '',
      this.watchList,
      this.status = BlocStateStatus.initial});
}
