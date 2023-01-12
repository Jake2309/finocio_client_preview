import 'package:flutter/material.dart';
import 'package:stockolio/model/market/stock_overview.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/shared/styles.dart';
import 'package:stockolio/shared/text_helper.dart';
import 'package:stockolio/shared/color_helper.dart';

class MarketStockCard extends StatelessWidget {
  final StockOverviewModel data;

  MarketStockCard({required this.data});

  static const _kCompanyNameStyle =
      const TextStyle(color: Color(0XFFc2c2c2), fontSize: 13, height: 1.5);

  static const _kStockTickerSymbol =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static const _kStockPriceStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
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
              Expanded(flex: 8, child: _buildCompanyData()),
              Expanded(flex: 4, child: _buildPriceData())
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: kStandatBorder),
        onPressed: () {
          // Trigger fetch event.
          // BlocProvider
          //   .of<ProfileBloc>(context)
          //   .add(FetchProfileData(symbol: data.symbol));

          // Send to Profile.
          // Navigator.push(context, MaterialPageRoute(builder: (_) => Profile(symbol: data.symbol)));
        },
      ),
    );
  }

  /// This method is in charge of rendering the stock company data.
  /// This is the left side in the card.
  /// It renders the  [symbol] and the company [name] from [data].
  Widget _buildCompanyData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(data.code, style: _kStockTickerSymbol),
        SizedBox(height: 4.0),
        Text(
          data.name,
          style: _kCompanyNameStyle,
        )
      ],
    );
  }

  /// This method is in charge of rendering the stock company data.
  /// This is the right side in the card.
  /// It renders the [change] and the stock's [price] from [data].
  Widget _buildPriceData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Container(
            width: data.changePercent > 99.99 ? null : 75.5,
            decoration: BoxDecoration(
                borderRadius: kSharpBorder,
                color: determineColorBasedOnChange(data.changeAmount)),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(determineTextBasedOnChange(data.changeAmount),
                textAlign: TextAlign.end),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(formatText(data.price),
              textAlign: TextAlign.end, style: _kStockPriceStyle),
        ),
      ],
    );
  }
}
