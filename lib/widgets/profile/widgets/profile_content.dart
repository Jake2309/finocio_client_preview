import 'package:flutter/material.dart';
import 'package:stockolio/model/market/stock_chart.dart';
import 'package:stockolio/model/market/stock_info.dart';
import 'package:stockolio/model/market/stock_quote.dart';
import 'package:stockolio/shared/color_helper.dart';
import 'package:stockolio/shared/styles.dart';
import 'package:stockolio/shared/text_helper.dart';
import 'package:stockolio/widgets/profile/widgets/profile_graph.dart';
import 'package:stockolio/widgets/profile/widgets/profile_sumary.dart';

class ProfileContent extends StatelessWidget {
  final Color color;
  final StockQuote stockQuote;
  final StockInfo stockInfo;
  final List<StockChart> stockChart;

  ProfileContent({
    required this.color,
    required this.stockInfo,
    required this.stockQuote,
    required this.stockChart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 26, right: 26, top: 26),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.stockQuote.name ?? '-', style: kProfileCompanyName),
            _buildPrice(context),
            Container(
                height: 250,
                padding: EdgeInsets.only(top: 26),
                child: SimpleTimeSeriesChart(
                    chart: this.stockChart, color: this.color)),
            ProfileSumary(
              quote: stockQuote,
              profile: stockInfo,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('\$${formatText(stockQuote.price)}', style: priceStyle),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${determineTextBasedOnChange(stockQuote.change!)}  (${determineTextPercentageBasedOnChange(stockQuote.changesPercentage!)})',
                  style: determineTextStyleBasedOnChange(stockQuote.change!)),
              Container(
                  // child: FlatButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => ChartDetail(
                  //             socketIOManage: SocketIOManage(),
                  //             stockQuote: stockQuote),
                  //       ),
                  //     );
                  //   },
                  //   child: Text(
                  //     'View Chart',
                  //     style: TextStyle(color: kPositiveColor),
                  //   ),
                  // ),
                  )
            ],
          ),
        ],
      ),
    );
  }
}
