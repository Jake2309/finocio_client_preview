import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:stockolio/helpers/response_code.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/helpers/server_define.dart';
import 'package:stockolio/model/news/news_response.dart';
import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/network/dio_client.dart';
import 'package:stockolio/repository/authen_repository/i_auth_repo.dart';
import 'package:stockolio/repository/new_repository/i_news_repo.dart';

@Injectable(as: INewsRepo)
class NewsRepo implements INewsRepo {
  final DioClient _dioClient;

  NewsRepo(
    this._dioClient,
  );

  @override
  Future<Result<NewsResponse>> GetNewsByFavouriteList(
      List<String> favouriteSymbols) async {
    try {
      var responseMap = await _dioClient.get(ServerUri.NEWS_API +
          '/api/1/news?apikey=${ServerUri.NEWS_DATA_API_KEY}&q=btc&language=en&category=business,technology');

      Result<NewsResponse> result = Result.fromJson(responseMap);

      if (result.code == HttpStatus.ok) {
        var data = NewsResponse.fromMap(responseMap['results']);

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
}
