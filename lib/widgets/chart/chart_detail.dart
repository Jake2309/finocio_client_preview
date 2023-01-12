// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stockolio/bloc/technical/technical_bloc.dart';
import 'package:stockolio/bloc/technical/technical_event.dart';
import 'package:stockolio/bloc/technical/technical_state.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/library/k_chart_library/flutter_k_chart.dart';
import 'package:stockolio/library/k_chart_library/renderer/base_chart_renderer.dart';
import 'package:stockolio/model/candle/ohlc.dart';
import 'package:stockolio/model/market/stock_quote.dart';
import 'package:stockolio/repository/market_repo/market_repo.dart';
import 'package:stockolio/shared/color_helper.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/shared/text_helper.dart';
import 'package:stockolio/widgets/common/empty_screen.dart';
import 'package:stockolio/widgets/common/loading_indicator.dart';

class ChartDetail extends StatefulWidget {
  final StockQuote stockQuote;
  final OHLC? realtimeData;
  const ChartDetail({
    Key? key,
    required this.stockQuote,
    this.realtimeData,
  }) : super(key: key);

  @override
  _ChartDetailState createState() => _ChartDetailState();
}

class _ChartDetailState extends State<ChartDetail> {
  late List<KLineEntity> datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = false;
  bool isVietnamese = false;
  late List<DepthEntity> _bids, _asks;
  late StockQuote stkQuote;

  @override
  void initState() {
    super.initState();
    // getData('1day');
    rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      Map tick = parseJson['tick'];
      var bids = tick['bids']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      var asks = tick['asks']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      initDepth(bids, asks);
    });
  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids.insert(0, item);
    });

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks.add(item);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    stkQuote = widget.stockQuote;
    return Scaffold(
      backgroundColor: kScaffoldBackground, //Color(0xff17212F),
      appBar: AppBar(
        title: Text(
          this.stkQuote.name!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: kPositiveColor,
      ),
      body: BlocProvider(
          create: (context) => getIt<TechnicalBloc>(),
          child: BlocBuilder<TechnicalBloc, TechnicalState>(
              builder: (context, state) {
            if (state is TechnicalInitial) {
              BlocProvider.of<TechnicalBloc>(context).add(
                  TechnicalFetchChartData(
                      symbol: stkQuote.symbol!, sucuritiyType: 'CRYPTO'));
            }

            if (state is TechnicalFetchChartDataInProgress)
              return LoadingIndicatorWidget();

            if (state is TechnicalFetchChartDataSuccess) {
              datas = state.kLineData;
              showLoading = false;
              return buildNormalContent(
                this.stkQuote,
              );
            }

            if (state is TechnicalFetchChartDataFailure) {
              showLoading = false;
              // setState(() {});
              return EmptyScreen(
                message: state.errMsg,
              );
            }

            return EmptyScreen(
              message: 'no data',
            );
          })),
    );
  }

  Widget buildContentWithHeaderSliver() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: kPositiveColor,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            title: Text(
              this.stkQuote.name!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // price and change percent
                  Row(
                    children: [
                      Text('\$${formatText(this.stkQuote.price)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      Text(
                          '${determineTextBasedOnChange(this.stkQuote.change!)}  (${determineTextPercentageBasedOnChange(this.stkQuote.changesPercentage!)})',
                          style: determineTextStyleBasedOnChange(
                              this.stkQuote.change!)),
                    ],
                  ),
                  // high, low, vol
                  Row(),
                ],
              ),
            ),
          ),
        ];
      },
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            // Container(
            //   height: 450,
            //   width: double.infinity,
            //   child: KChartWidget(
            //     datas,
            //     currentPoint,
            //     isLine: isLine,
            //     mainState: _mainState,
            //     volHidden: _volHidden,
            //     secondaryState: _secondaryState,
            //     fixedLength: 2,
            //     timeFormat: TimeFormat.YEAR_MONTH_DAY,
            //     isVietnamese: isVietnamese,
            //   ),
            // ),
            // if (showLoading)
            //   Container(
            //     width: double.infinity,
            //     height: 450,
            //     alignment: Alignment.center,
            //     child: CircularProgressIndicator(),
            //   ),
          ]),
          buildTechnicalButton(),
          Container(
            height: 230,
            width: double.infinity,
            child: DepthChart(
              bids: _bids,
              asks: _asks,
              chartColors: ChartColors(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNormalContent(StockQuote stkQuote) {
    return ListView(
      children: <Widget>[
        Container(
          height: 100,
          // color: kPositiveColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // price and change percent
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${formatText(stkQuote.price)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  Text(
                      '${determineTextBasedOnChange(stkQuote.change!)}  (${determineTextPercentageBasedOnChange(stkQuote.changesPercentage!)})',
                      style: determineTextStyleBasedOnChange(stkQuote.change!)),
                ],
              ),
              // high, low, vol
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('High: ${formatText(stkQuote.price)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  Text('Low: ${formatText(stkQuote.price)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  Text('Volume: ${formatText(stkQuote.volume)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 30,
          // color: Colors.grey,
          child: Row(
            children: [
              expandedButton('1H', onPressed: () => {}),
              expandedButton('4H', onPressed: () => {}),
              expandedButton('1D', onPressed: () => {}),
              expandedButton('1W', onPressed: () => {}),
              Expanded(
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      key: Key('1m'),
                      value: '1m',
                      child: Text(
                        '1m',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      key: Key('15m'),
                      value: '15m',
                      child: Text(
                        '15m',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      key: Key('30m'),
                      value: '30m',
                      child: Text(
                        '30m',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      key: Key('6H'),
                      value: '6H',
                      child: Text(
                        '6H',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      key: Key('12H'),
                      value: '12H',
                      child: Text(
                        '12H',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                  onChanged: (value) {},
                ),
              ),
              expandedButton('Line', onPressed: () => isLine = true),
            ],
          ),
        ),
        // Candle chart
        Stack(children: <Widget>[
          Container(
            height: 450,
            padding: EdgeInsets.only(top: 10),
            width: double.infinity,
            child: KChartWidget(
              datas: datas,
              isLine: isLine,
              mainState: _mainState,
              volHidden: _volHidden,
              secondaryState: _secondaryState,
              fixedLength: 2,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              isVietnamese: isVietnamese,
              bgColor: [],
              isTrendLine: false,
              chartColors: ChartColors(),
              chartStyle: ChartStyle(),
            ),
          ),
          if (showLoading)
            Container(
              width: double.infinity,
              height: 450,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
        ]),
        buildTechnicalButton(),
        Container(
          height: 230,
          width: double.infinity,
          child: DepthChart(
            bids: _bids,
            asks: _asks,
            chartColors: ChartColors(),
          ),
        )
      ],
    );
  }

  Widget buildTechnicalButton() {
    return Row(
      children: [
        expandedButton('MA', onPressed: () => _mainState = MainState.MA),
        expandedButton('BOLL', onPressed: () => _mainState = MainState.BOLL),
        expandedButton('MACD',
            onPressed: () => _secondaryState = SecondaryState.MACD),
        expandedButton('RSI',
            onPressed: () => _secondaryState = SecondaryState.RSI),
        expandedButton('KDJ',
            onPressed: () => _secondaryState = SecondaryState.KDJ),
        expandedButton('WR',
            onPressed: () => _secondaryState = SecondaryState.WR)
      ],
    );
  }

  Widget expandedButton(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
            // setState(() {});
          }
        },
        child: Text(
          "$text",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
