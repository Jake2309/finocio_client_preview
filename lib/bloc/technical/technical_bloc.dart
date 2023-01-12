import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stockolio/bloc/technical/technical_event.dart';
import 'package:stockolio/bloc/technical/technical_state.dart';
import 'package:stockolio/model/market/candel_search_request.dart';
import 'package:stockolio/repository/market_repo/i_market_repo.dart';
import 'package:stockolio/repository/market_repo/market_repo.dart';

@injectable
class TechnicalBloc extends Bloc<TechnicalEvent, TechnicalState> {
  IMarketRepo marketRepository;

  TechnicalBloc({required this.marketRepository}) : super(TechnicalInitial()) {
    on<TechnicalStarted>(
        (event, emit) => emit(TechnicalFetchChartDataInProgress()));
    on<TechnicalFetchChartData>((event, emit) async {
      var requestObj = new CandleSearchRequest(
        symbol: event.symbol,
        securities_type: event.sucuritiyType,
        search_interval: event.interval,
        limit: 100,
      );

      var chartResult = await marketRepository.FetchKlineEntities(requestObj);

      if (chartResult.success) {
        emit(TechnicalFetchChartDataSuccess(kLineData: chartResult.data!));
      } else {
        emit(TechnicalFetchChartDataFailure(errMsg: chartResult.message!));
      }
    });
  }
}
