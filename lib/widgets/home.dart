import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stockolio/router/router.gr.dart';
import 'package:stockolio/shared/colors.dart';

import 'market/markets.dart';
import 'portfolio/portfolio.dart';
import 'portfolio/portfolio_route.dart';

class StockolioAppHomeScreen extends StatefulWidget {
  @override
  _StockolioAppHomeScreenState createState() => _StockolioAppHomeScreenState();
}

class _StockolioAppHomeScreenState extends State<StockolioAppHomeScreen> {
  // int _selectedIndex = 0;

  // final List<Widget> tabs = [
  //   PortfolioScreen(),
  //   MarketsScreen(),
  //   PortfolioScreen(),
  //   PortfolioScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        // PortfolioRoute(),
        PortfolioTabRoute(),
        SocialRoute(),
        // MarketsRoute(),
        NewsRoute(),
        SettingsRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: kScaffoldBackground,
          body: FadeTransition(
            opacity: animation,
            // the passed child is techinaclly our animated selected-tab page
            child: child,
          ),
          //body: tabs.elementAt(_selectedIndex),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: GNav(
                gap: 12,
                activeColor: Colors.teal,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.teal[50]!,
                selectedIndex: tabsRouter.activeIndex, // _selectedIndex,
                tabs: _bottomNavigationBarItemItems(),
                onTabChange: (index) {
                  tabsRouter.setActiveIndex(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  List<GButton> _bottomNavigationBarItemItems() {
    return [
      GButton(
        // icon: FontAwesomeIcons.home,
        icon: Icons.account_balance_wallet,
        text: 'Danh mục',
      ),
      GButton(
        // icon: FontAwesomeIcons.store,
        icon: Icons.addchart_outlined,
        text: 'Cộng đồng',
      ),
      // GButton(
      //   icon: FontAwesomeIcons.search,
      //   // icon: Icons.search,
      //   text: 'Search',
      // ),
      GButton(
        // icon: FontAwesomeIcons.solidNewspaper,
        icon: Icons.library_books,
        text: 'Tin tức',
      ),
      GButton(
        // icon: FontAwesomeIcons.cog,
        icon: Icons.settings,
        text: 'Cài đặt',
      )
    ];
  }

  // void _onItemTapped(int index) {
  //   setState(() => _selectedIndex = index);
  // }
}
