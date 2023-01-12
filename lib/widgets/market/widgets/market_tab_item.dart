import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/market/market_bloc.dart';
import 'package:stockolio/bloc/market/market_event.dart';
import 'package:stockolio/bloc/market/market_state.dart';
import 'package:stockolio/model/market/stock_overview.dart';
import 'package:stockolio/widgets/common/empty_screen.dart';
import 'package:stockolio/widgets/common/loading_indicator.dart';
import 'package:stockolio/widgets/market/widgets/market_stock_card.dart';

class MarketTabItem extends StatefulWidget {
  final int tabIndex;
  final Tab currentTab;
  final bool isLoaded;
  final List<StockOverviewModel> data;

  MarketTabItem(
      {required this.tabIndex,
      required this.currentTab,
      required this.isLoaded,
      required this.data});
  @override
  State<StatefulWidget> createState() => _MarketTabItem();
}

class _MarketTabItem extends State<MarketTabItem>
    with AutomaticKeepAliveClientMixin {
  late List<StockOverviewModel> marketList;
  late MarketBloc _marketBloc;

  @override
  void initState() {
    super.initState();
    marketList = widget.data;
    _marketBloc = BlocProvider.of<MarketBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _marketBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    String currentTabKey = widget.currentTab.text!;
    return BlocBuilder<MarketBloc, MarketState>(
      builder: (context, state) {
        if (state is MarketInitial) {
          _marketBloc.add(FetchMarketData(exchangeName: currentTabKey));
        }

        if (state is MarketFetchDataSuccess) {
          return _buildStocksSection(stocks: state.data);
        }

        if (state is MarketFetchDataFailure) {
          return Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            child: EmptyScreen(message: state.errMsg),
          );
        }

        return Padding(
          padding: EdgeInsets.only(top: 30),
          child: LoadingIndicatorWidget(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _buildStocksSection({required List<StockOverviewModel> stocks}) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: stocks.length,
      itemBuilder: (BuildContext context, int index) {
        return MarketStockCard(data: stocks[index]);
      });
}
