import 'package:auto_route/auto_route.dart';
import 'package:stockolio/widgets/authen/login_screen.dart';
import 'package:stockolio/widgets/chart/chart_screen.dart';
import 'package:stockolio/widgets/home.dart';
import 'package:stockolio/widgets/market/markets.dart';
import 'package:stockolio/widgets/news/news_screen.dart';
import 'package:stockolio/widgets/portfolio/portfolio.dart';
import 'package:stockolio/widgets/portfolio/portfolio_route.dart';
import 'package:stockolio/widgets/settings/Settings.dart';
import 'package:stockolio/widgets/shared/error_screen.dart';
import 'package:stockolio/widgets/social/social_screen.dart';

import 'auth_guard.dart';

abstract class Routes {
  static const home = '/';
  static const login = '/login';
  static const error = '/error';

  static const market = 'market';
  static const portfolio = 'portfolio';
  static const news = 'news';
  static const social = 'social';
  static const settings = 'settings';

  static const chart_detail = 'chart-detail/:symbol';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, path: Routes.login),
    AutoRoute(
        page: StockolioAppHomeScreen,
        guards: [AuthGuard],
        path: Routes.home,
        children: [
          // AutoRoute(page: PortfolioScreen, path: Routes.portfolio, children: [
          //   AutoRoute(path: Routes.chart_detail, page: ChartScreen),
          // ]),
          portfolioTabRouter,
          AutoRoute(
            page: MarketsScreen,
            path: Routes.market,
          ),
          AutoRoute(
            page: NewsScreen,
            path: Routes.news,
          ),
          AutoRoute(
            page: SettingsScreen,
            path: Routes.settings,
          ),
          AutoRoute(
            page: SocialScreen,
            path: Routes.social,
          ),
        ]),
    // portfolioTabRouter,
    AutoRoute(page: ErrorScreen, path: Routes.error),
  ],
)
// extend the generated private router
class $AppRouter {}
