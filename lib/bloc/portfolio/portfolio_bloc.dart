import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stockolio/bloc/portfolio/portfolio_event.dart';
import 'package:stockolio/bloc/portfolio/portfolio_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/repository/portfolio_repository/i_portfolio_repo.dart';

@injectable
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final IPortfolioRepo portfolioRepository;

  PortfolioBloc({required this.portfolioRepository}) : super(PortfolioState()) {
    on<FetchPortfolioData>((event, emit) async {
      emit(PortfolioState(status: BlocStateStatus.loading));

      var watchList = await portfolioRepository.getWatchLists();

      if (watchList.success) {
        emit(PortfolioState(
            status: BlocStateStatus.success, watchList: watchList.data!));
      } else {
        emit(PortfolioState(
            status: BlocStateStatus.failure,
            message: 'Fetch portfolio data failure!'));
      }
    });
  }
}
