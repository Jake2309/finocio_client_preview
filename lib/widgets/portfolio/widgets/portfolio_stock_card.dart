import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/profile/profile_bloc.dart';
import 'package:stockolio/bloc/profile/profile_event.dart';
import 'package:stockolio/model/market/mini_ticker.dart';
import 'package:stockolio/router/router.gr.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/shared/styles.dart';
import 'package:stockolio/shared/text_helper.dart';
import 'package:stockolio/shared/color_helper.dart';
import 'package:stockolio/widgets/profile/profile.dart';

// Card thong tin item trong watchlist
// moi card chua thong tin co ban cua 1 co phieu
// khi click vao card -> redirect den man hinh profile
class PortfolioStockCard extends StatefulWidget {
  final String symbol;
  final MiniTicker realtimeData;
  final bool isUpdated;

  PortfolioStockCard({
    required this.symbol,
    required this.realtimeData,
    this.isUpdated = false,
  });

  @override
  State<StatefulWidget> createState() => _PortfolioStockCardState();
}

class _PortfolioStockCardState extends State<PortfolioStockCard> {
  late String _symbol;

  @override
  Widget build(BuildContext context) {
    _symbol = widget.symbol;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: MaterialButton(
        color: kTileColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 8, child: _buildCompanyName()),
              Expanded(flex: 4, child: _buildPriceData())
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: kStandatBorder),
        onPressed: () {
          // Trigger fetch event.
          // BlocProvider.of<ProfileBloc>(context)
          //     .add(ProfileFetchData(symbol: _symbol));

          AutoRouter.of(context).push(ChartRoute(symbol: 'BTCUSDT'));

          // Send to Profile.
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => Profile(
          //       symbol: _symbol,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  /// This method is in charge of rendering the stock company _stockOverviewModel.
  /// This is the left side in the card.
  /// It renders the  [symbol] and the company [name] from [_stockOverviewModel].
  Widget _buildCompanyName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_symbol, style: kStockTickerSymbol),
        SizedBox(height: 4.0),
        Text(
          _symbol,
          style: kCompanyNameStyle,
        )
      ],
    );
  }

  /// This method is in charge of rendering the stock company _stockOverviewModel.
  /// This is the right side in the card.
  /// It renders the [change] and the stock's [price] from [_stockOverviewModel].
  Widget _buildPriceData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Container(
            width: widget.realtimeData.changePercent > 99.99 ? null : 75.5,
            decoration: BoxDecoration(
              borderRadius: kSharpBorder,
              color: widget.isUpdated
                  ? determineColorBasedOnChange(widget.realtimeData.change)
                  : determineColorBasedOnChange(0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
                widget.isUpdated
                    ? determineTextBasedOnChange(widget.realtimeData.change)
                    : determineTextBasedOnChange(0),
                textAlign: TextAlign.end),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
              formatText(
                  widget.isUpdated ? widget.realtimeData.currentPrice : 0.0),
              textAlign: TextAlign.end,
              style: kStockPriceStyle),
        ),
      ],
    );
  }
}
