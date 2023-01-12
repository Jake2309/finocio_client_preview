import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/helpers/http_helper.dart';
import 'package:stockolio/helpers/response_code.dart';
import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/helpers/server_define.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/library/k_chart_library/flutter_k_chart.dart';
import 'package:stockolio/model/market/candel_search_request.dart';
import 'package:stockolio/model/market/market_search_response.dart';
import 'package:stockolio/model/market/stock_overview.dart';
import 'package:stockolio/model/sampleData.dart';
import 'package:http/http.dart' as http;
import 'package:stockolio/network/dio_client.dart';
import 'package:stockolio/repository/market_repo/i_market_repo.dart';

@Injectable(as: IMarketRepo)
class MarketRepository implements IMarketRepo {
  final DioClient _dioClient;

  MarketRepository(this._dioClient);

  @override
  Future<List<StockOverviewModel>> getMarketDataByExchange(
      String exchangeName) {
    return Future.delayed(Duration(milliseconds: 1000),
        () => SampleData.getExchangeSymbols(exchangeName));
  }

  @override
  Future<Result<List<MarketSearchResponse>>> FilterSymbol(String symbol) async {
    try {
      var responseMap = await _dioClient
          .get(ServerUri.FINO_API + '/api/market/filter-symbol/$symbol');
      Result<List<MarketSearchResponse>> result = Result.fromJson(responseMap);

      if (result.code == HttpStatus.ok) {
        List<MarketSearchResponse> data = List<MarketSearchResponse>.from(
          responseMap['data']
              .map((model) => MarketSearchResponse.fromJson(model))
              .toList(),
        );

        result.data = data;

        return result;
      } else {
        print('FilterSymbol error: ${result.message}');
        return Result(code: result.code, message: result.message);
      }

      // var response = await http.get(
      //   requestUri,
      //   headers: {"Content-type": "application/json"},
      // ).timeout(
      //   const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
      // );
      // if (response.statusCode == HttpStatus.ok) {
      //   Iterable resData = jsonDecode(response.body)['data'];

      //   var data = resData
      //       .map((model) => MarketSearchResponse.fromJson(model))
      //       .toList();

      //   return new Result(data: data);
      // } else {
      //   print('Filter symbol error!');

      //   return new Result<List<MarketSearchResponse>>(
      //       code: ResponseCode.UNKNOW_ERROR, message: response.body);
      // }
    } catch (e) {
      print(e.toString());

      return new Result<List<MarketSearchResponse>>(
          code: ResponseCode.SYS_GENERIC_ERROR);
    }
  }

  @override
  Future<Result<List<KLineEntity>>> FetchKlineEntities(
      CandleSearchRequest request) async {
    try {
      var bodyRequest = json.encode(request.toJson());
      var responseMap = await _dioClient.post(
          ServerUri.FINO_API + '/api/chart/klines-by-symbol',
          data: bodyRequest);
      Result<List<KLineEntity>> result = Result.fromJson(responseMap);

      if (result.code == HttpStatus.ok) {
        List<KLineEntity> data = List<KLineEntity>.from(
          responseMap['data']
              .map((model) => KLineEntity.fromJson(json.encode(model)))
              // .reversed
              .toList(),
        );

        if (data.length > 0) {
          DataUtil.calculate(data);

          result.data = data;
        } else {
          result.data = <KLineEntity>[];
        }

        return result;
      } else {
        print('FetchKlineEntities error: ${result.message}');
        return Result(code: result.code, message: result.message);
      }
      // var requestUri =
      //     Uri.parse(ServerUri.FINO_API + '/api/chart/klines-by-symbol');

      // String token =
      //     'await SecureStorageManager.readKey(Preferences.auth_token)';
      // // String token = await SecureStorageManager.readKey(Preferences.auth_token);

      // var bodyRequest = json.encode(request.toJson());

      // var response = await HttpHelper.post(requestUri, bodyRequest, token);

      // // var response = await http.post(
      // //   requestUri,
      // //   body: ,
      // //   headers: {"Content-type": "application/json"},
      // // ).timeout(
      // //   const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
      // // );
      // if (response.statusCode == HttpStatus.ok) {
      //   Iterable resData = jsonDecode(response.body)['data'];

      //   var datas = resData
      //       .map((item) => KLineEntity.fromJson(item))
      //       .toList()
      //       .reversed
      //       .toList()
      //       .cast<KLineEntity>();

      //   DataUtil.calculate(datas);

      //   return new Result(data: datas);
      // } else {
      //   print('Filter symbol error!');

      //   return new Result<List<KLineEntity>>(
      //       code: ResponseCode.UNKNOW_ERROR, message: response.body);
      // }
    } catch (e) {
      print(e.toString());

      return new Result<List<KLineEntity>>(
          code: ResponseCode.SYS_GENERIC_ERROR);
    }
  }

  @override
  Future<Result<List<KLineEntity>>> fetchHoubiTradingData(String period) async {
    if (period.isEmpty) period = '1day';

    var responseMap = await _dioClient.get(
      'https://api.huobi.br.com/market/history/kline?period=$period&size=100&symbol=btcusdt',
    );
    Result<List<KLineEntity>> result = Result.fromJson(responseMap);

    if (result.code == HttpStatus.ok) {
      List<KLineEntity> data = List<KLineEntity>.from(
        responseMap['data']
            .map((model) => KLineEntity.fromJson(model))
            .reversed
            .toList(),
      );

      DataUtil.calculate(data);

      result.data = data;

      return result;
    } else {
      print('fetchHoubiTradingData error: ${result.message}');
      return Result(code: result.code, message: result.message);
    }

    // Uri path = Uri.parse(
    //     'https://api.huobi.br.com/market/history/kline?period=$period&size=100&symbol=btcusdt');
    // String result;
    // var response = await http.get(path);
    // if (response.statusCode == 200) {
    //   result = response.body;
    // } else {
    //   print('Failed getting data from huobi, get sample data!!!!');
    //   result = sampleDataStr;
    // }

    // Map parseJson = json.decode(result);
    // List list = parseJson['data'];
    // var datas = list
    //     .map((item) => KLineEntity.fromJson(item))
    //     .toList()
    //     .reversed
    //     .toList()
    //     .cast<KLineEntity>();

    // DataUtil.calculate(datas);

    // return new Result(data: datas);
  }
}

String sampleDataStr =
    '{"data":[{"id":1605024000,"open":15168.02,"close":15396.9,"low":15112.15,"high":15500,"amount":12364.421682618293,"vol":189843513.61103123,"count":174428},{"id":1604937600,"open":15004.24,"close":15168.03,"low":14813,"high":15491.34,"amount":29847.28646129053,"vol":455357989.1401526,"count":388377},{"id":1604851200,"open":15354.61,"close":15004.24,"low":14934.26,"high":15850,"amount":46707.575707467135,"vol":721192238.2556374,"count":466990},{"id":1604764800,"open":15342.64,"close":15354.61,"low":14366,"high":15450.01,"amount":40030.645315910864,"vol":599354138.1559778,"count":464329},{"id":1604678400,"open":15408.46,"close":15342.64,"low":15180,"high":15753.88,"amount":27811.906619509642,"vol":430796623.4177301,"count":363819},{"id":1604592000,"open":15076.96,"close":15411.23,"low":14800,"high":15985,"amount":68162.9676460744,"vol":1055177027.6322238,"count":709617},{"id":1604505600,"open":13911.96,"close":15077.18,"low":13886.64,"high":15150,"amount":54586.13821699717,"vol":788043048.5249326,"count":577493},{"id":1604419200,"open":13708.92,"close":13911.95,"low":13524.7,"high":14058,"amount":36143.3015509102,"vol":498599440.220474,"count":390022},{"id":1604332800,"open":13492.15,"close":13708.92,"low":13286.26,"high":13799,"amount":30005.983998813892,"vol":406257058.5598601,"count":364009},{"id":1604246400,"open":13797.97,"close":13492.15,"low":13192.98,"high":13863.23,"amount":36300.605196519,"vol":492648664.3052716,"count":394442}]}';
