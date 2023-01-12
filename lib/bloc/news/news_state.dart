import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/model/news/news_response.dart';

class NewsState {
  final String message;
  BlocStateStatus status;
  NewsResponse? data;

  NewsState(
      {this.message = '', this.data, this.status = BlocStateStatus.initial});
}
