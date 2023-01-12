import 'package:flutter/material.dart';

import 'market_tab_item.dart';

// ignore: must_be_immutable
class MarketContentSection extends StatefulWidget {
  TabController tabController;
  List<Tab> marketTabs;

  MarketContentSection({required this.tabController, required this.marketTabs});

  @override
  _MarketContentSectionState createState() => _MarketContentSectionState();
}

class _MarketContentSectionState extends State<MarketContentSection>
    with AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late List<Tab> tabList;

  @override
  void initState() {
    super.initState();

    _tabController = widget.tabController;
    tabList = widget.marketTabs;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: List<Widget>.generate(tabList.length, (index) {
        Tab tabItem = tabList[index];
        return MarketTabItem(
            tabIndex: index, currentTab: tabItem, isLoaded: false, data: []);
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
