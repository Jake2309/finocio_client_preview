import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/helpers/http_helper.dart';
import 'package:stockolio/helpers/response_code.dart';
import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/helpers/server_define.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/model/market/stock_overview.dart';
import 'package:stockolio/model/portfolio/fino_portfolio.dart';
import 'package:stockolio/model/portfolio/update_portfolio_request.dart';
import 'package:stockolio/network/dio_client.dart';
import 'package:stockolio/repository/portfolio_repository/i_portfolio_repo.dart';

@Injectable(as: IPortfolioRepo)
class PortfolioRepository implements IPortfolioRepo {
  final DioClient _dioClient;

  PortfolioRepository(this._dioClient);

  @override
  Future<Result<List<FinoPortfolio>>> getWatchLists() async {
    try {
      var responseMap = await _dioClient
          .get(ServerUri.FINO_API + '/api/portfolio/list-portfolio');

      Result<List<FinoPortfolio>> result = Result.fromJson(responseMap);

      if (result.code == HttpStatus.ok) {
        List<FinoPortfolio> data = List<FinoPortfolio>.from(
          responseMap['data']
              .map((model) => FinoPortfolio.fromMap(model))
              .toList(),
        );

        result.data = data;

        return result;
      } else {
        print('getWatchLists error: ${result.code}');

        return new Result(
            code: ResponseCode.UNKNOW_ERROR, message: result.message);
      }
    } catch (e) {
      print(json.encode(e));
      rethrow;
    }
  }

  @override
  Future<bool> saveToWatchList(String symbol) {
    return Future.delayed(Duration(microseconds: 500));
  }

  @override
  Future<Result> updateWatchlist(UpdatePortfolioRequest request) async {
    try {
      Uri path =
          Uri.parse(ServerUri.FINO_API + '/api/portfolio/update-portfolio');
      String token =
          'await SecureStorageManager.readKey(Preferences.auth_token)';

      if (token == null || token.isEmpty) {
        return Result<List<StockOverviewModel>>(
          success: false,
          code: ResponseCode.TOKEN_INVALID,
        );
      }

      var bodyRequest = json.encode(request.toJson());

      var response = await HttpHelper.post(path, bodyRequest, token);

      if (response.statusCode == HttpStatus.ok) {
        var resMap = jsonDecode(response.body);

        var result = Result.fromJson(resMap);

        return result;
      } else {
        return Result(code: response.statusCode, message: response.body);
      }
    } catch (e) {
      return Result(
          code: ResponseCode.SYS_GENERIC_ERROR,
          message: 'Error when update portfolio.');
    }
  }

  @override
  Future<Result> getPortfolio(Int64 id) async {
    try {
      var responseMap = await _dioClient
          .get(ServerUri.FINO_API + '/api/portfolio/get-portfolio/$id');
      var result = Result.fromJson(responseMap);

      if (result.code == HttpStatus.ok) {
        result.data = FinoPortfolio.fromJson(responseMap['data']);

        return result;
      } else {
        return Result(code: result.code, message: result.message);
      }
    } catch (e) {
      return Result(
          code: ResponseCode.SYS_GENERIC_ERROR,
          message: 'Error when update portfolio.');
    }
  }
}
