import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/socketio/socketio_bloc.dart';
import 'package:stockolio/bloc/socketio/socketio_event.dart';
import 'package:stockolio/bloc/socketio/socketio_state.dart';
import 'package:stockolio/model/candle/ohlc.dart';
// import 'package:stockolio/socket_io/socket_io_manage.dart';
import 'chart_style.dart';
import 'chart_translations.dart';
import 'entity/info_window_entity.dart';
import 'entity/k_line_entity.dart';
import 'renderer/chart_painter.dart';
import 'renderer/main_renderer.dart';
import 'utils/date_format_util.dart';

enum MainState { MA, BOLL, NONE }

enum SecondaryState { MACD, KDJ, RSI, WR, CCI, NONE }

class TimeFormat {
  static const List<String> YEAR_MONTH_DAY = [yyyy, '-', mm, '-', dd];
  static const List<String> YEAR_MONTH_DAY_WITH_HOUR = [
    yyyy,
    '-',
    mm,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn
  ];
}

// Class draw chart: which is candlestick or polyline
class KChartWidget extends StatefulWidget {
  final List<KLineEntity> datas;
  final MainState mainState;
  final bool volHidden;
  final SecondaryState secondaryState;
  final Function()? onSecondaryTap;
  final bool isLine;
  final bool isVietnamese;
  final bool isTapShowInfoDialog;
  final bool hideGrid;
  final Map<String, ChartTranslations> translations;
  final List<String> timeFormat;
  final bool showNowPrice;
  final bool showInfoDialog;
  final bool materialInfoDialog;
  //It will be called when the screen scrolls to the end,
  //true to the end of the right side of the screen,
  //false to the end of the left side of the screen
  final Function(bool)? onLoadMore;

  final int fixedLength;
  final List<int> maDayList;
  final int flingTime;
  final double flingRatio;
  final Curve flingCurve;
  final Function(bool)? isOnDrag;
  final ChartColors chartColors;
  final ChartStyle chartStyle;
  final VerticalTextAlignment verticalTextAlignment;
  final bool isTrendLine;
  final List<Color> bgColor;
  // final SocketIOManage socketIOManage;

  KChartWidget({
    required this.isTrendLine,
    this.mainState = MainState.MA,
    this.secondaryState = SecondaryState.MACD,
    this.onSecondaryTap,
    this.volHidden = false,
    this.isLine = false,
    this.isTapShowInfoDialog = false,
    this.hideGrid = false,
    this.isVietnamese = false,
    this.showNowPrice = true,
    this.showInfoDialog = true,
    this.materialInfoDialog = true,
    this.translations = kChartTranslations,
    this.timeFormat = TimeFormat.YEAR_MONTH_DAY,
    this.onLoadMore,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.flingTime = 600,
    this.flingRatio = 0.5,
    this.flingCurve = Curves.decelerate,
    this.isOnDrag,
    this.verticalTextAlignment = VerticalTextAlignment.left,
    required this.bgColor,
    required this.datas,
    required this.chartColors,
    required this.chartStyle,
  });

  @override
  _KChartWidgetState createState() => _KChartWidgetState();
}

class _KChartWidgetState extends State<KChartWidget>
    with TickerProviderStateMixin {
  // ty le phong dai cua chart
  double mScaleX = 0.8;
  double mScrollX = 0.0, mSelectX = 0.0;
  late StreamController<InfoWindowEntity>? mInfoWindowStream;
  double mWidth = 0;
  late AnimationController _controller;
  late AnimationController _canvasRedrawController;
  late Animation<double> aniX;
  late SocketIOBloc _socketIOBloc;

  double mHeight = 0;

  //For TrendLine
  List<TrendLine> lines = [];
  double? changeinXposition;
  double? changeinYposition;
  double mSelectY = 0.0;
  bool waitingForOtherPairofCords = false;
  bool enableCordRecord = false;

  double getMinScrollX() {
    return mScaleX;
  }

  double _lastScale = 1.0;
  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      // duration: widget.duration,
    );
    mInfoWindowStream = StreamController<InfoWindowEntity>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mInfoWindowStream?.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _socketIOBloc = BlocProvider.of<SocketIOBloc>(context);
    if (widget.datas.isEmpty) {
      mScrollX = mSelectX = 0.0;
      mScaleX = 1.0;
    }

    var chartPainter = ChartPainter(
      widget.chartStyle,
      widget.chartColors,
      lines: lines, //For TrendLine
      isTrendLine: widget.isTrendLine, //For TrendLine
      selectY: mSelectY, //For TrendLine
      datas: widget.datas,
      scaleX: mScaleX,
      scrollX: mScrollX,
      selectX: mSelectX,
      isLongPass: isLongPress,
      isOnTap: isOnTap,
      isTapShowInfoDialog: widget.isTapShowInfoDialog,
      mainState: widget.mainState,
      volHidden: widget.volHidden,
      secondaryState: widget.secondaryState,
      isLine: widget.isLine,
      hideGrid: widget.hideGrid,
      showNowPrice: widget.showNowPrice,
      sink: mInfoWindowStream?.sink,
      fixedLength: widget.fixedLength,
      maDayList: widget.maDayList,
      verticalTextAlignment: widget.verticalTextAlignment,
      currentPoint: ValueNotifier(widget.datas.last),
    );

    return GestureDetector(
      onHorizontalDragDown: (details) {
        _stopAnimation();
        _onDragChanged(true);
      },
      onHorizontalDragUpdate: (details) {
        if (isScale || isLongPress) return;
        mScrollX = ((details.primaryDelta ?? 0) / mScaleX + mScrollX)
            .clamp(0.0, ChartPainter.maxScrollX)
            .toDouble();
        notifyChanged();
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        var velocity = details.velocity.pixelsPerSecond.dx;
        _onFling(velocity);
      },
      onHorizontalDragCancel: () => _onDragChanged(false),
      onScaleStart: (_) {
        isScale = true;
      },
      onScaleUpdate: (details) {
        if (isDrag || isLongPress) return;
        mScaleX = (_lastScale * details.scale).clamp(0.5, 2.2);
        notifyChanged();
      },
      onScaleEnd: (_) {
        isScale = false;
        _lastScale = mScaleX;
      },
      onLongPressStart: (details) {
        isLongPress = true;
        if (mSelectX != details.globalPosition.dx) {
          mSelectX = details.globalPosition.dx;
          notifyChanged();
        }
      },
      onLongPressMoveUpdate: (details) {
        if (mSelectX != details.globalPosition.dx) {
          mSelectX = details.globalPosition.dx;
          notifyChanged();
        }
      },
      onLongPressEnd: (details) {
        isLongPress = false;
        // mInfoWindowStream?.sink.add(null);
        notifyChanged();
      },
      child: Stack(
        children: <Widget>[
          Container(
            child: CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: chartPainter,
              child: StreamBuilder<OHLC>(
                  stream: _socketIOBloc.getOHLCResponse,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        print('connection waiting...');
                        // chartPainter.updateCurrentPoint(widget.datas.last);

                        // Future.delayed(Duration(milliseconds: 1000));
                        break;
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          OHLC msgData = snapshot.data!;

                          if (msgData.symbol == "BTCUSDT") {
                            // print(
                            //   'data: open: ${msgData.open} high: ${msgData.high} low: ${msgData.low} close: ${msgData.close}',
                            // );

                            var realtimeMsg = KLineEntity.fromCustom(
                              amount: msgData.quoteVolume,
                              open: msgData.open,
                              high: msgData.high,
                              low: msgData.low,
                              close: msgData.close,
                              vol: msgData.baseVolume,
                              time: msgData.endTime,
                            );

                            chartPainter.updateCurrentPoint(realtimeMsg);
                          }
                        }
                        break;
                      default:
                    }
                    return Container();
                  }),
            ),
          ),
          // Container(
          //   child: StreamBuilder<OHLC>(
          //     stream: _socketIOManage.getResponse,
          //     builder: (context, snapshot) {
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return CustomPaint(
          //             size: Size(double.infinity, double.infinity),
          //             painter: ChartPainter(
          //               datas: widget.datas,
          //               currentPoint: widget.datas.last,
          //               scaleX: mScaleX,
          //               scrollX: mScrollX,
          //               selectX: mSelectX,
          //               isLongPass: isLongPress,
          //               mainState: widget.mainState,
          //               volHidden: widget.volHidden,
          //               secondaryState: widget.secondaryState,
          //               isLine: widget.isLine,
          //               isFirstLoad: true,
          //               sink: mInfoWindowStream?.sink,
          //               bgColor: widget.bgColor,
          //               fixedLength: widget.fixedLength,
          //               maDayList: widget.maDayList,
          //             ),
          //             // child: Container(),
          //           );

          //           // Future.delayed(Duration(milliseconds: 1000));
          //           break;
          //         case ConnectionState.active:
          //           if (snapshot.hasData) {
          //             OHLC msgData = snapshot.data;

          //             if (msgData.symbol == "BTCUSDT") {
          //               var realtimeMsg = KLineEntity.fromCustom(
          //                   amount: msgData.quoteVolume,
          //                   open: msgData.open,
          //                   high: msgData.high,
          //                   low: msgData.low,
          //                   close: msgData.close,
          //                   vol: msgData.baseVolume);

          //               return AnimatedBuilder(
          //                 animation: _canvasRedrawController,
          //                 builder: (context, animatedWidget) {
          //                   return CustomPaint(
          //                     size: Size(double.infinity, double.infinity),
          //                     painter: ChartPainter(
          //                       datas: widget.datas,
          //                       currentPoint: realtimeMsg,
          //                       scaleX: mScaleX,
          //                       scrollX: mScrollX,
          //                       selectX: mSelectX,
          //                       isLongPass: isLongPress,
          //                       mainState: widget.mainState,
          //                       volHidden: widget.volHidden,
          //                       secondaryState: widget.secondaryState,
          //                       isLine: widget.isLine,
          //                       isFirstLoad: false,
          //                       sink: mInfoWindowStream?.sink,
          //                       bgColor: widget.bgColor,
          //                       fixedLength: widget.fixedLength,
          //                       maDayList: widget.maDayList,
          //                     ),
          //                     // child: Container(
          //                     //   height: 200,
          //                     // ),
          //                   );
          //                 },
          //               );
          //             }
          //           }
          //           break;
          //         default:
          //       }

          //       return Container();
          //     },
          //   ),
          // ),
          _buildInfoDialog()
        ],
      ),
    );
  }

  Widget buildRealTimeData(SocketIOBloc socketBloc, ChartPainter chartPainter) {
    return BlocBuilder<SocketIOBloc, SocketIOState>(builder: (context, state) {
      if (state is SocketIOStateInitial) {
        socketBloc.add(OnConnect());
      }
      if (state is SocketIOStateConnecting) {}
      if (state is SocketIOStateConnected) {
        // for (var i = 0; i < symbols.length; i++) {
        //   socketBloc.add(OnSubcribe(channelNames: symbols));
        // }
        // socketBloc.add(OnSubcribe(channelNames: ['BTCUSDT']));
      }

      if (state is SocketIOStateSubcribed) {
        return Container(
          child: StreamBuilder<OHLC>(
              stream: socketBloc.getOHLCResponse,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    // chartPainter.updateCurrentPoint(widget.datas.last);

                    // Future.delayed(Duration(milliseconds: 1000));
                    break;
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      OHLC msgData = snapshot.data!;

                      if (msgData.symbol == "BTCUSDT") {
                        // print(
                        //   'data: open: ${msgData.open} high: ${msgData.high} low: ${msgData.low} close: ${msgData.close}',
                        // );

                        var realtimeMsg = KLineEntity.fromCustom(
                          amount: msgData.quoteVolume,
                          open: msgData.open,
                          high: msgData.high,
                          low: msgData.low,
                          close: msgData.close,
                          vol: msgData.baseVolume,
                          time: msgData.endTime,
                        );

                        chartPainter.updateCurrentPoint(realtimeMsg);
                      }
                    }
                    break;
                  default:
                }
                return Container();
              }),
        );
      }

      return Container();
    });
  }

  void _stopAnimation({bool needNotify = true}) {
    if (_controller != null && _controller.isAnimating) {
      _controller.stop();
      _onDragChanged(false);
      if (needNotify) {
        notifyChanged();
      }
    }
  }

  void _onDragChanged(bool isOnDrag) {
    isDrag = isOnDrag;
    if (widget.isOnDrag != null) {
      widget.isOnDrag!(isDrag);
    }
  }

  void _onFling(double x) {
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.flingTime), vsync: this);
    // aniX = null;
    aniX = Tween<double>(begin: mScrollX, end: x * widget.flingRatio + mScrollX)
        .animate(
            CurvedAnimation(parent: _controller, curve: widget.flingCurve));
    aniX.addListener(() {
      mScrollX = aniX.value;
      if (mScrollX <= 0) {
        mScrollX = 0;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(true);
        }
        _stopAnimation();
      } else if (mScrollX >= ChartPainter.maxScrollX) {
        mScrollX = ChartPainter.maxScrollX;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(false);
        }
        _stopAnimation();
      }
      notifyChanged();
    });
    aniX.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _onDragChanged(false);
        notifyChanged();
      }
    });
    _controller.forward();
  }

  void notifyChanged() => setState(() {});

  final List<String> infoNamesVN = [
    "Ngày",
    "Giá mở cửa",
    "Giá cao nhất",
    "Giá thấp nhất",
    "Giá đóng cửa",
    "Thay đổi",
    "Thay đổi %",
    "Giá trị"
  ];
  final List<String> infoNamesEN = [
    "Date",
    "Open",
    "High",
    "Low",
    "Close",
    "Change",
    "Change%",
    "Amount"
  ];
  late List<String> infos;

  // Dialog show candle infomation when long press
  Widget _buildInfoDialog() {
    return StreamBuilder<InfoWindowEntity>(
        stream: mInfoWindowStream!.stream,
        builder: (context, snapshot) {
          if (!isLongPress ||
              widget.isLine == true ||
              !snapshot.hasData ||
              snapshot.data!.kLineEntity == null) return Container();
          KLineEntity entity = snapshot.data!.kLineEntity;
          double upDown = entity.change ?? entity.close - entity.open;
          double upDownPercent = entity.ratio ?? (upDown / entity.open) * 100;
          infos = [
            getDate(entity.time!),
            entity.open.toStringAsFixed(widget.fixedLength),
            entity.high.toStringAsFixed(widget.fixedLength),
            entity.low.toStringAsFixed(widget.fixedLength),
            entity.close.toStringAsFixed(widget.fixedLength),
            "${upDown > 0 ? "+" : ""}${upDown.toStringAsFixed(widget.fixedLength)}",
            "${upDownPercent > 0 ? "+" : ''}${upDownPercent.toStringAsFixed(2)}%",
            entity.amount!.toInt().toString()
          ];
          return Container(
            margin: EdgeInsets.only(
                left: snapshot.data!.isLeft ? 4 : mWidth - mWidth / 3 - 4,
                top: 25),
            width: mWidth / 3,
            decoration: BoxDecoration(
                color: ChartColors().selectFillColor,
                border: Border.all(
                    color: ChartColors().selectBorderColor, width: 0.5)),
            child: ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: infoNamesVN.length,
              itemExtent: 14.0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItem(
                    infos[index],
                    widget.isVietnamese
                        ? infoNamesVN[index]
                        : infoNamesEN[index]);
              },
            ),
          );
        });
  }

  Widget _buildItem(String info, String infoName) {
    Color color = Colors.white;
    if (info.startsWith("+"))
      color = Colors.green;
    else if (info.startsWith("-"))
      color = Colors.red;
    else
      color = Colors.white;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Text("$infoName",
                style: const TextStyle(color: Colors.white, fontSize: 10.0))),
        Text(info, style: TextStyle(color: color, fontSize: 10.0)),
      ],
    );
  }

  String getDate(int date) =>
      dateFormat(DateTime.fromMillisecondsSinceEpoch(date), widget.timeFormat);
}
