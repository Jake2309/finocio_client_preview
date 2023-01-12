import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/news/news_event.dart';
import 'package:stockolio/bloc/news/news_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/repository/new_repository/i_news_repo.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final INewsRepo newsRepo;
  NewsBloc({required this.newsRepo}) : super(NewsState()) {
    on<NewsInitital>(
        (event, emit) => NewsState(status: BlocStateStatus.loading));
    on<FetchNewsData>((event, emit) async {
      var result = await newsRepo.GetNewsByFavouriteList(event.symbols);

      emit(
        NewsState(
          status: BlocStateStatus.success,
          data: result.data,
        ),
      );
    });
  }
}
