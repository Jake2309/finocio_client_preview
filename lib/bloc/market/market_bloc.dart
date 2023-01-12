import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockolio/model/sampleData.dart';
import 'package:stockolio/repository/market_repo/i_market_repo.dart';
import 'package:stockolio/repository/market_repo/market_repo.dart';

import 'market_state.dart';
import 'market_event.dart';

@injectable
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final IMarketRepo marketRepository;
  // final SharedPreferences localStorageManager;

  MarketBloc({required this.marketRepository}) : super(MarketInitial()) {
    on<MarketTabChanged>((event, emit) => _onTabChanged(event, emit));
    on<FetchMarketData>((event, emit) => _onFetchMarketData(event, emit));
    on<SymbolSearch>((event, emit) => _onSymbolSearch(event, emit));
  }

  void _onTabChanged(MarketTabChanged event, Emitter<MarketState> emit) async {
    try {
      final SharedPreferences localStorageManager =
          await SharedPreferences.getInstance();

      emit(MarketFetchDataInprogress());
      if (localStorageManager.containsKey(event.currentTab)) {
        var exchangeCodeData =
            localStorageManager.getStringList(event.currentTab);

        var exchangeData =
            SampleData.getExchangeSymbolByCodes(exchangeCodeData!);

        emit(MarketFetchDataSuccess(data: exchangeData));
      } else {
        this.add(FetchMarketData(exchangeName: event.currentTab));
      }
    } catch (e) {
      print(e.toString());
      emit(MarketHandlerException(exceptionMsg: e.toString()));
    }
  }

  void _onFetchMarketData(
      FetchMarketData event, Emitter<MarketState> emit) async {
    try {
      final SharedPreferences localStorageManager =
          await SharedPreferences.getInstance();
      emit(MarketFetchDataInprogress());
      var exchangeSymbols =
          await marketRepository.getMarketDataByExchange(event.exchangeName);

      if (exchangeSymbols != null) {
        if (exchangeSymbols.length > 0) {
          var symbolCodes = exchangeSymbols.map((e) => e.code).toList();

          localStorageManager.setStringList(event.exchangeName, symbolCodes);
        }
        emit(MarketFetchDataSuccess(data: exchangeSymbols));
      } else {
        emit(MarketFetchDataFailure(
            errMsg:
                'Load market data of exchange ${event.exchangeName} failure!!'));
      }
    } catch (e) {
      print(e.toString());
      emit(MarketHandlerException(exceptionMsg: e.toString()));
    }
  }

  void _onSymbolSearch(SymbolSearch event, Emitter<MarketState> emit) async {
    try {
      emit(SymbolSearching());
      var searchResult = await marketRepository.FilterSymbol(event.symbol);

      if (searchResult.success) {
        print('search market data success!!!');
        emit(SymbolSearchSuccess(
            response: searchResult.data!, lastQuery: event.symbol));
      } else {
        emit(SymbolSearchFailure(errMsg: searchResult.message!));
      }
    } catch (e) {
      print(e.toString());
      emit(MarketHandlerException(exceptionMsg: e.toString()));
    }
  }
}
