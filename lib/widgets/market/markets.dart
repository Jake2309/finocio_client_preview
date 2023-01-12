import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:stockolio/bloc/market/market_bloc.dart';
import 'package:stockolio/bloc/market/market_event.dart';
import 'package:stockolio/bloc/market/market_state.dart';
import 'package:stockolio/model/sampleData.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/common/empty_screen.dart';
import 'package:stockolio/widgets/market/widgets/market_content.dart';
import 'package:stockolio/widgets/market/widgets/market_heading.dart';

class MarketsScreen extends StatefulWidget {
  @override
  _MarketSectionState createState() => _MarketSectionState();
}

class _MarketSectionState extends State<MarketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final exchangeList = SampleData.getExchanges();

  final marketTabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    for (var item in exchangeList) {
      marketTabs.add(Tab(
        text: item.code,
      ));
    }
    _tabController = TabController(length: exchangeList.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        BlocProvider.of<MarketBloc>(context).add(MarketTabChanged(
            currentTab: marketTabs[_tabController.index].text!));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      appBar: PreferredSize(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  MarketHeadingSection(),
                  BlocBuilder<MarketBloc, MarketState>(
                      builder: (context, state) {
                    return TabBar(
                      tabs: marketTabs,
                      controller: _tabController,
                      // onTap: (tabIndex) => {
                      //   BlocProvider.of<MarketBloc>(context).add(
                      //       MarketTabChanged(
                      //           currentTab: marketTabs[tabIndex].text))
                      // },
                    );
                  }),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(110)),
      body: OfflineBuilder(
          child: Container(),
          connectivityBuilder: (
            context,
            connectivity,
            child,
          ) {
            return connectivity == ConnectivityResult.none
                ? _buildNoConnectionMessage(context)
                : _buildContent(context);
          }),
    );
  }

  Widget _buildNoConnectionMessage(context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 14, left: 24, right: 24),
      child: EmptyScreen(
          message: 'Looks like you don\'t have an internet connection.'),
    );
  }

  Widget _buildContent(context) {
    return RefreshIndicator(
      child: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: MarketContentSection(
                marketTabs: marketTabs,
                tabController: _tabController,
              ),
            )
          ],
        ),
      ),
      onRefresh: () async {
        // Reload stocks section.
        // BlocProvider.of<PortfolioBloc>(context).add(FetchPortfolioData());
      },
    );
  }
}
