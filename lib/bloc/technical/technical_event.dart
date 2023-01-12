import 'package:equatable/equatable.dart';
import 'package:stockolio/helpers/definitions.dart';

abstract class TechnicalEvent extends Equatable {}

class TechnicalStarted extends TechnicalEvent {
  @override
  List<Object> get props => [];
}

// Event trigger load chart_data of specified symbol
class TechnicalFetchChartData extends TechnicalEvent {
  final String symbol;
  final String sucuritiyType;
  final String interval;
  TechnicalFetchChartData({
    required this.symbol,
    required this.sucuritiyType,
    this.interval = TechnicalInterval.HOUR_4,
  });
  @override
  List<Object> get props => [this.symbol, this.sucuritiyType, this.interval];
}
