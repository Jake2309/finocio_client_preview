import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/profile/profile_bloc.dart';
import 'package:stockolio/bloc/profile/profile_event.dart';
import 'package:stockolio/model/profile/stock_profile.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/profile/widgets/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  final bool isSaved;
  final Color color;
  final StockProfile profile;

  ProfileScreen({
    required this.isSaved,
    required this.profile,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          centerTitle: true,
          title: Text(this.profile.stockQuote.symbol!),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            // WatchlistButtonWidget(
            //   storageModel: StorageModel(
            //       symbol: profile.stockQuote.symbol,
            //       companyName: profile.stockQuote.name),
            //   isSaved: isSaved,
            //   color: Colors.white,
            // )
          ],
        ),
        backgroundColor: kScaffoldBackground,
        body: RefreshIndicator(
            child: SafeArea(
              // child: ChartDetail(
              //   stockQuote: profile.stockQuote,
              // ),
              child: ProfileContent(
                color: color,
                stockInfo: profile.stockInfo,
                stockChart: profile.stockCharts,
                stockQuote: profile.stockQuote,
              ),
              // ProfileNewsScreen(news: profile.stockNews,),
            ),
            onRefresh: () async {
              // Reload profile section.
              BlocProvider.of<ProfileBloc>(context).add(
                  ProfileFetchData(symbol: this.profile.stockQuote.symbol!));
            }));
  }
}
