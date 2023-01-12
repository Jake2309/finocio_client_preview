import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:stockolio/bloc/portfolio/portfolio_common.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/common/empty_screen.dart';
import 'package:stockolio/widgets/market/widgets/market_search.dart';
import 'package:stockolio/widgets/portfolio/widgets/portfolio_content.dart';

import 'widgets/portfolio_heading.dart';

// Man hinh danh sach watchlist
class PortfolioScreen extends StatelessWidget {
  final int tabLenght = 3;
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      child: Container(),
      connectivityBuilder: (
        context,
        connectivity,
        child,
      ) {
        // Khong co mang, show man hinh thong bao
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            backgroundColor: kScaffoldBackground,
            appBar: PreferredSize(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: PortfolioHeadingSection(),
                  ),
                ),
                preferredSize: Size.fromHeight(65)),
            body: _buildNoConnectionMessage(context),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {},
              child: const Icon(Icons.add),
              backgroundColor: Colors.white,
            ),
          );
        } else {
          return DefaultTabController(
            length: tabLenght,
            child: Scaffold(
              backgroundColor: kScaffoldBackground,
              appBar: PreferredSize(
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: PortfolioHeadingSection(),
                    ),
                  ),
                  preferredSize: Size.fromHeight(65)),
              body: _buildContent(context),
              floatingActionButton: FloatingActionButton(
                onPressed: () async => {
                  showSearch(
                    context: context,
                    delegate: MarketSearch(),
                  ),
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  _buildNoConnectionMessage(context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 14, left: 24, right: 24),
      child: EmptyScreen(
          message: 'Looks like you don\'t have an internet connection.'),
    );
  }

  _buildContent(context) {
    List<Widget> tabContents = [];
    for (var i = 0; i < tabLenght; i++) {
      tabContents.add(RefreshIndicator(
        child: SafeArea(
          child: ListView(
            // disabled scroll refresh
            // physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              PortfolioContentScreen(),
            ],
          ),
        ),
        onRefresh: () async {
          // Reload stocks section.
          BlocProvider.of<PortfolioBloc>(context)
              .add(FetchPortfolioData(isUserLoggedIn: true));
        },
      ));
    }
    return TabBarView(
      children: tabContents,
    );
  }
}
