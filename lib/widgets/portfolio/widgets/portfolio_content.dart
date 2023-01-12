import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/portfolio/portfolio_common.dart';
import 'package:stockolio/bloc/socketio/socketio_bloc.dart';
import 'package:stockolio/bloc/socketio/socketio_event.dart';
import 'package:stockolio/bloc/socketio/socketio_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/model/market/mini_ticker.dart';
import 'package:stockolio/model/portfolio/fino_portfolio.dart';
import 'package:stockolio/widgets/common/empty_screen.dart';
import 'package:stockolio/widgets/common/loading_indicator.dart';
import 'package:stockolio/widgets/portfolio/widgets/portfolio_stock_card.dart';

class PortfolioContentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortfolioContentSectionState();
}

class _PortfolioContentSectionState extends State<PortfolioContentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PortfolioBloc _portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStateStatus.initial:
            _portfolioBloc.add(FetchPortfolioData(isUserLoggedIn: true));
            break;
          case BlocStateStatus.loading:
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: LoadingIndicatorWidget(),
            );
          case BlocStateStatus.success:
            return _buildStocksSection(portfolios: state.watchList!);
          case BlocStateStatus.failure:
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: EmptyScreen(message: state.message),
            );
          default:
        }

        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          child: LoadingIndicatorWidget(),
        );
      },
    );
  }

  // Doan nay lien tuc render ra listview moi khi stream co du lieu moi, de review lai sau co the day socketIOManage vao tung
  // item de listen data change
  _buildStocksSection({required List<FinoPortfolio> portfolios}) {
    // ignore: close_sinks
    SocketIOBloc socketBloc = BlocProvider.of<SocketIOBloc>(context);

    List<String> symbols = portfolios[0].watch_list.split(',');

    return BlocBuilder<SocketIOBloc, SocketIOState>(builder: (context, state) {
      if (state is SocketIOStateInitial) {
        socketBloc.add(OnConnect());
      }
      if (state is SocketIOStateConnecting) {}
      if (state is SocketIOStateConnected) {
        // for (var i = 0; i < symbols.length; i++) {
        //   socketBloc.add(OnSubcribe(channelNames: symbols));
        // }
        socketBloc.add(OnSubcribe(channelNames: ['BTCUSDT']));
      }

      if (state is SocketIOStateSubcribed) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: symbols.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: StreamBuilder<MiniTicker>(
                stream: socketBloc.getMiniTickerResponse,
                builder:
                    (BuildContext context, AsyncSnapshot<MiniTicker> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container();
                      break;
                    case ConnectionState.done:
                      return Container();
                      break;
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        var currentSymbol = symbols[index];

                        MiniTicker msgData = snapshot.data!;

                        return PortfolioStockCard(
                            symbol: currentSymbol,
                            realtimeData: msgData,
                            isUpdated: true // currentSymbol == msgData.symbol,
                            );
                      }
                      break;
                    case ConnectionState.none:
                      return Container();
                  }

                  return Container();
                },
              ),
            );
          },
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: portfolios.length,
        itemBuilder: (BuildContext context, int index) {
          var currentPortfolio = portfolios[index];

          for (var portfolioDetail in currentPortfolio.details) {
            MiniTicker msgData = MiniTicker(
              symbol: portfolioDetail.symbol,
              currentPrice: portfolioDetail.price,
              change: portfolioDetail.price,
              changePercent: portfolioDetail.change_percent,
            );

            return PortfolioStockCard(
                symbol: portfolioDetail.symbol,
                realtimeData: msgData,
                isUpdated: true // currentSymbol == msgData.symbol,
                );
          }

          return Container();
        },
      );
    });
  }
}
