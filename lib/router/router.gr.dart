// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i11;

import '../widgets/authen/login_screen.dart' as _i1;
import '../widgets/chart/chart_screen.dart' as _i10;
import '../widgets/home.dart' as _i2;
import '../widgets/market/markets.dart' as _i5;
import '../widgets/news/news_screen.dart' as _i6;
import '../widgets/portfolio/portfolio.dart' as _i9;
import '../widgets/settings/Settings.dart' as _i7;
import '../widgets/shared/error_screen.dart' as _i3;
import '../widgets/social/social_screen.dart' as _i8;
import 'auth_guard.dart' as _i12;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i12.AuthGuard authGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.LoginScreen());
    },
    StockolioAppHomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.StockolioAppHomeScreen());
    },
    ErrorRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ErrorScreen());
    },
    PortfolioTabRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    MarketsRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.MarketsScreen());
    },
    NewsRoute.name: (routeData) {
      final args =
          routeData.argsAs<NewsRouteArgs>(orElse: () => const NewsRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.NewsScreen(key: args.key));
    },
    SettingsRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouteArgs>(
          orElse: () => const SettingsRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.SettingsScreen(key: args.key));
    },
    SocialRoute.name: (routeData) {
      final args = routeData.argsAs<SocialRouteArgs>(
          orElse: () => const SocialRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.SocialScreen(key: args.key));
    },
    PortfolioRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.PortfolioScreen());
    },
    ChartRoute.name: (routeData) {
      final args = routeData.argsAs<ChartRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.ChartScreen(key: args.key, symbol: args.symbol));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(LoginRoute.name, path: '/login'),
        _i4.RouteConfig(StockolioAppHomeRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i4.RouteConfig(PortfolioTabRoute.name,
              path: 'portfolio',
              parent: StockolioAppHomeRoute.name,
              children: [
                _i4.RouteConfig(PortfolioRoute.name,
                    path: '', parent: PortfolioTabRoute.name),
                _i4.RouteConfig(ChartRoute.name,
                    path: 'chart-detail/:symbol',
                    parent: PortfolioTabRoute.name)
              ]),
          _i4.RouteConfig(MarketsRoute.name,
              path: 'market', parent: StockolioAppHomeRoute.name),
          _i4.RouteConfig(NewsRoute.name,
              path: 'news', parent: StockolioAppHomeRoute.name),
          _i4.RouteConfig(SettingsRoute.name,
              path: 'settings', parent: StockolioAppHomeRoute.name),
          _i4.RouteConfig(SocialRoute.name,
              path: 'social', parent: StockolioAppHomeRoute.name)
        ]),
        _i4.RouteConfig(ErrorRoute.name, path: '/error')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.StockolioAppHomeScreen]
class StockolioAppHomeRoute extends _i4.PageRouteInfo<void> {
  const StockolioAppHomeRoute({List<_i4.PageRouteInfo>? children})
      : super(StockolioAppHomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'StockolioAppHomeRoute';
}

/// generated route for
/// [_i3.ErrorScreen]
class ErrorRoute extends _i4.PageRouteInfo<void> {
  const ErrorRoute() : super(ErrorRoute.name, path: '/error');

  static const String name = 'ErrorRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class PortfolioTabRoute extends _i4.PageRouteInfo<void> {
  const PortfolioTabRoute({List<_i4.PageRouteInfo>? children})
      : super(PortfolioTabRoute.name,
            path: 'portfolio', initialChildren: children);

  static const String name = 'PortfolioTabRoute';
}

/// generated route for
/// [_i5.MarketsScreen]
class MarketsRoute extends _i4.PageRouteInfo<void> {
  const MarketsRoute() : super(MarketsRoute.name, path: 'market');

  static const String name = 'MarketsRoute';
}

/// generated route for
/// [_i6.NewsScreen]
class NewsRoute extends _i4.PageRouteInfo<NewsRouteArgs> {
  NewsRoute({_i11.Key? key})
      : super(NewsRoute.name, path: 'news', args: NewsRouteArgs(key: key));

  static const String name = 'NewsRoute';
}

class NewsRouteArgs {
  const NewsRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'NewsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i4.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({_i11.Key? key})
      : super(SettingsRoute.name,
            path: 'settings', args: SettingsRouteArgs(key: key));

  static const String name = 'SettingsRoute';
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SocialScreen]
class SocialRoute extends _i4.PageRouteInfo<SocialRouteArgs> {
  SocialRoute({_i11.Key? key})
      : super(SocialRoute.name,
            path: 'social', args: SocialRouteArgs(key: key));

  static const String name = 'SocialRoute';
}

class SocialRouteArgs {
  const SocialRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SocialRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.PortfolioScreen]
class PortfolioRoute extends _i4.PageRouteInfo<void> {
  const PortfolioRoute() : super(PortfolioRoute.name, path: '');

  static const String name = 'PortfolioRoute';
}

/// generated route for
/// [_i10.ChartScreen]
class ChartRoute extends _i4.PageRouteInfo<ChartRouteArgs> {
  ChartRoute({_i11.Key? key, required String symbol})
      : super(ChartRoute.name,
            path: 'chart-detail/:symbol',
            args: ChartRouteArgs(key: key, symbol: symbol));

  static const String name = 'ChartRoute';
}

class ChartRouteArgs {
  const ChartRouteArgs({this.key, required this.symbol});

  final _i11.Key? key;

  final String symbol;

  @override
  String toString() {
    return 'ChartRouteArgs{key: $key, symbol: $symbol}';
  }
}
