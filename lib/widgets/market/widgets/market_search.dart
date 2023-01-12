import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockolio/bloc/market/market_bloc.dart';
import 'package:stockolio/bloc/market/market_event.dart';
import 'package:stockolio/bloc/market/market_state.dart';
import 'package:stockolio/helpers/ultilities.dart';
import 'package:stockolio/model/market/market_search_response.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/shared/styles.dart';
import 'package:stockolio/widgets/common/loading_indicator.dart';

class MarketSearch extends SearchDelegate {
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container();
  }

  String? resultSearch;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(resultSearch!),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MarketSearchResponse> symbolSearchs = [];
    String lastQuery = '';
    bool _throwShotAway = false;

    return BlocBuilder<MarketBloc, MarketState>(builder: (context, state) {
      _debouncer.run(() {
        print('run symbol search');
        if (query.isNotEmpty && query.length >= 2) {
          symbolSearchs.clear();
          if (lastQuery.isEmpty ||
              (lastQuery.isNotEmpty && query.toUpperCase() != lastQuery)) {
            BlocProvider.of<MarketBloc>(context)
                .add(SymbolSearch(symbol: query.toUpperCase()));
          }

          if (state is SymbolSearching) {
            // return LoadingIndicatorWidget();
          }

          if (state is SymbolSearchSuccess) {
            symbolSearchs = state.response;
            lastQuery = state.lastQuery;
          }

          if (state is SymbolSearchFailure) {
            // return Container(
            //   child: Text(state.errMsg),
            // );
          }

          if (state is MarketHandlerException) {
            // return Container(
            //   child: Text(state.exceptionMsg),
            // );
          }
        }
      });

      if (symbolSearchs.length > 0) {
        return ListView.builder(
          itemCount: symbolSearchs.length,
          itemBuilder: (context, index) {
            return StatefulBuilder(builder: (context, setState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Checkbox(
                              value: _throwShotAway,
                              onChanged: (newValue) {
                                setState(() {
                                  _throwShotAway = newValue!;
                                });
                              },
                            ),
                          )),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(symbolSearchs[index].symbol,
                                style: kStockTickerSymbol),
                            SizedBox(height: 4.0),
                            Text(
                              symbolSearchs[index].name,
                              style: kCompanyNameStyle,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: FaIcon(
                              FontAwesomeIcons.chartBar,
                              size: 20.0,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
          },
        );
      }

      return Container();
    });
  }

  Widget _buildSearchItem(MarketSearchResponse response) {
    bool _throwShotAway = false;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                child: Checkbox(
                  value: _throwShotAway,
                  onChanged: (newValue) {
                    print('checkbox change');
                    // setState(() {
                    //   _throwShotAway = newValue;
                    // });

                    print(_throwShotAway);
                  },
                ),
              )),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(response.symbol, style: kStockTickerSymbol),
                SizedBox(height: 4.0),
                Text(
                  response.name,
                  style: kCompanyNameStyle,
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: FaIcon(
                FontAwesomeIcons.addressBook,
                size: 20.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // assert(context != null);
    // final ThemeData theme = Theme.of(context);
    // assert(theme != null);
    // theme.backgroundColor = kScaffoldBackground,
    // return theme;
    return Theme.of(context).copyWith(
      backgroundColor: kScaffoldBackground,
      // primaryColor: Theme.of(context).scaffoldBackgroundColor,
      // primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      // primaryColorBrightness: Brightness.dark,
      // primaryTextTheme: theme.textTheme,
    );
    // return ThemeData(brightness: Brightness.dark);
  }
}
