import 'package:auto_route/auto_route.dart';
import 'package:stockolio/router/router.dart';
import 'package:stockolio/widgets/chart/chart_screen.dart';
import 'package:stockolio/widgets/portfolio/portfolio.dart';

const portfolioTabRouter = AutoRoute(
  path: Routes.portfolio,
  name: 'PortfolioTabRoute',
  page: EmptyRouterPage,
  children: [
    AutoRoute(path: '', page: PortfolioScreen),
    AutoRoute(path: Routes.chart_detail, page: ChartScreen),
  ],
);
