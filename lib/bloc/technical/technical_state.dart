import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stockolio/library/k_chart_library/entity/k_line_entity.dart';

abstract class TechnicalState extends Equatable {}

class TechnicalInitial extends TechnicalState {
  @override
  List<Object> get props => [];
}

class TechnicalFetchChartDataInProgress extends TechnicalState {
  @override
  List<Object> get props => [];
}

class TechnicalFetchChartDataSuccess extends TechnicalState {
  final List<KLineEntity> kLineData;

  TechnicalFetchChartDataSuccess({required this.kLineData});

  @override
  List<Object> get props => [kLineData];
}

class TechnicalFetchChartDataFailure extends TechnicalState {
  final String errMsg;

  TechnicalFetchChartDataFailure({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}
