import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/model/news/news_response.dart';

abstract class INewsRepo {
  Future<Result<NewsResponse>> GetNewsByFavouriteList(
      List<String> favouriteSymbols);
}
