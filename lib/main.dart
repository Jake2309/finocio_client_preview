import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/auth/auth_bloc.dart';
import 'package:stockolio/bloc/market/market_bloc.dart';
import 'package:stockolio/bloc/portfolio/portfolio_bloc.dart';
import 'package:stockolio/bloc/profile/profile_bloc.dart';
import 'package:stockolio/bloc/socketio/socketio_bloc.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/helpers/finocio_http_overide.dart';
import 'package:stockolio/repository/profile_repository/profile_repo.dart';
import 'package:stockolio/router/router.gr.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/authen/login_screen.dart';
import 'package:stockolio/widgets/common/loading_indicator.dart';

import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = new FinocioHttpOveride();
  await configureDependencies();

  runApp(FinocioApp());
}

class FinocioApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FinocioApp();
}

class _FinocioApp extends State<FinocioApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  final _appRouter = getIt<AppRouter>();

  // Define an async function to initialize FlutterFire
  // void initializeFlutterFire() async {
  //   try {
  //     // Wait for Firebase to initialize and set `_initialized` state to true
  //     await Firebase.initializeApp();
  //     setState(() {
  //       _initialized = true;
  //     });
  //   } catch (e) {
  //     log('${json.encode(e)}');
  //     // Set `_error` state to true if Firebase initialization fails
  //     setState(() {
  //       _error = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    // initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt.get<AuthBloc>(),
        ),
        BlocProvider<PortfolioBloc>(
          create: (context) => getIt.get<PortfolioBloc>(),
        ),
        BlocProvider<SocketIOBloc>(create: (context) => SocketIOBloc()),
        BlocProvider<MarketBloc>(
          create: (context) => getIt.get<MarketBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            profileRepository: ProfileRepository(),
          ),
        )
      ],
      child: MaterialApp.router(
        title: 'STOCKOLIO',
        theme: ThemeData(
            brightness: Brightness.dark, backgroundColor: kScaffoldBackground),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        // home: _initFireBaseAuth(context),
        // home: StockolioAppHomeScreen(),
        debugShowCheckedModeBanner: false,
        // builder: (context, child) {
        //   return BlocBuilder<AuthBloc, AuthState>(
        //     builder: (BuildContext context, state) {
        //       switch (state.status) {
        //         case BlocStateStatus.initial:
        //           BlocProvider.of<AuthBloc>(context).add(AppStated());
        //           break;
        //         case BlocStateStatus.loading:
        //           break;
        //         // return LoadingIndicatorWidget();
        //         case BlocStateStatus.success:
        //           _appRouter.push(StockolioAppHomeRoute());
        //           break;
        //         // return StockolioAppHomeScreen();
        //         case BlocStateStatus.failure:
        //           _appRouter.push(LoginRoute());
        //           break;
        //         // return LoginScreen();
        //         default:
        //           return LoadingIndicatorWidget();
        //       }

        //       return child!;
        //     },
        //   );
        // },
      ),
    );
  }

  Widget _initFireBaseAuth(BuildContext context, Widget? child) {
    // Show error message if initialization failed
    if (_error) {
      return Container(
        child: Text('ERROR!!!!'),
      );
    }

    if (_initialized) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          switch (state.status) {
            case BlocStateStatus.initial:
              BlocProvider.of<AuthBloc>(context).add(AppStated());
              break;
            case BlocStateStatus.loading:
              break;
            // return LoadingIndicatorWidget();
            case BlocStateStatus.success:
              _appRouter.push(StockolioAppHomeRoute());
              break;
            // return StockolioAppHomeScreen();
            case BlocStateStatus.failure:
              _appRouter.push(LoginRoute());
              break;
            // return LoginScreen();
            default:
              return LoadingIndicatorWidget();
          }

          return LoginScreen();
        },
        // child: child,
      );
      // return BlocBuilder<AuthBloc, AuthState>(
      //   builder: (BuildContext context, state) {
      //     switch (state.status) {
      //       case BlocStateStatus.initial:
      //         BlocProvider.of<AuthBloc>(context).add(AppStated());
      //         break;
      //       case BlocStateStatus.loading:
      //         return LoadingIndicatorWidget();
      //       case BlocStateStatus.success:
      //         return StockolioAppHomeScreen();
      //       case BlocStateStatus.failure:
      //         return LoginScreen();
      //       default:
      //         return LoadingIndicatorWidget();
      //     }

      //     return LoadingIndicatorWidget();
      //   },
      // );
    }

    // Show a loader until FlutterFire is initialized
    return LoadingIndicatorWidget();
  }
}
