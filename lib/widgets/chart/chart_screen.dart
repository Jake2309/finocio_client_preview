import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/profile/profile_bloc.dart';
import 'package:stockolio/bloc/profile/profile_event.dart';
import 'package:stockolio/bloc/profile/profile_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/model/candle/ohlc.dart';
import 'package:stockolio/model/market/stock_quote.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/socket_io/socket_io_manage.dart';
import 'package:stockolio/widgets/common/empty_screen.dart';
import 'package:stockolio/widgets/common/loading_indicator.dart';
import 'package:stockolio/widgets/chart/chart_detail.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({Key? key, required this.symbol}) : super(key: key);

  final String symbol;
  // final OHLC realtimeData;
  late SocketIOManage? socketIOManage;

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context)
        .add(ProfileFetchData(symbol: widget.symbol));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
      switch (state.status) {
        case BlocStateStatus.initial:
          break;
        case BlocStateStatus.loading:
          break;
        case BlocStateStatus.success:
          return ChartDetail(
            stockQuote: state.profileData!.stockQuote,
          );
        case BlocStateStatus.failure:
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kNegativeColor,
              title: Text(':('),
            ),
            backgroundColor: kScaffoldBackground,
            body: Center(
              child: EmptyScreen(message: state.message),
            ),
          );
        default:
      }

      return Scaffold(
          backgroundColor: kScaffoldBackground, body: LoadingIndicatorWidget());
      // if (state is ProfileFetchDataFailure) {
      //   return Scaffold(
      //       appBar: AppBar(
      //         backgroundColor: kNegativeColor,
      //         title: Text(':('),
      //       ),
      //       backgroundColor: kScaffoldBackground,
      //       body: Center(child: EmptyScreen(message: state.errMsg)));
      // }

      // if (state is ProfileFetchDataSuccess) {
      //   return ChartDetail(
      //     socketIOManage: socketIOManage,
      //     stockQuote: state.profileData.stockQuote,
      //     // realtimeData: realtimeData,
      //   );
      //   // return ProfileScreen(
      //   //   isSaved: state.isSaved,
      //   //   profile: state.profileData,
      //   //   color:
      //   //       determineColorBasedOnChange(state.profileData.stockInfo.changes),
      //   // );
      // }
    });
  }

  // ignore: unused_element
  Widget _buildRealtimeChart(SocketIOManage socketIO, StockQuote stockQuote) {
    return StreamBuilder<OHLC>(
      stream: socketIO.getResponse,
      builder: (BuildContext context, AsyncSnapshot<OHLC> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container();
            break;
          case ConnectionState.done:
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: LoadingIndicatorWidget(),
            );
            break;
          case ConnectionState.active:
            if (snapshot.hasData) {
              return ChartDetail(
                // socketIOManage: socketIOManage,
                stockQuote: stockQuote,
                // realtimeData: realtimeData,
              );
            }
            break;
          case ConnectionState.none:
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: LoadingIndicatorWidget(),
            );
            break;
        }

        return Container();
      },
    );
  }
}
