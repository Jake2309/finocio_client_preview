import 'package:auto_route/auto_route.dart';
import 'package:stockolio/router/router.dart';
import 'package:stockolio/widgets/market/markets.dart';

const marketTab = AutoRoute(
  path: Routes.market,
  name: 'MarketTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(path: '', page: MarketsScreen),
  ],
);
