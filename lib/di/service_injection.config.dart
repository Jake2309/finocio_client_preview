// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app.module.dart' as _i21;
import '../bloc/auth/auth_bloc.dart' as _i19;
import '../bloc/login/login_bloc.dart' as _i20;
import '../bloc/market/market_bloc.dart' as _i13;
import '../bloc/portfolio/portfolio_bloc.dart' as _i14;
import '../bloc/technical/technical_bloc.dart' as _i16;
import '../helpers/secure_storage_manager.dart' as _i15;
import '../network/dio_client.dart' as _i5;
import '../network/firebase_service.dart' as _i6;
import '../repository/authen_repository/authen_repo.dart' as _i18;
import '../repository/authen_repository/i_auth_repo.dart' as _i17;
import '../repository/market_repo/i_market_repo.dart' as _i7;
import '../repository/market_repo/market_repo.dart' as _i8;
import '../repository/new_repository/i_news_repo.dart' as _i9;
import '../repository/new_repository/news_repo.dart' as _i10;
import '../repository/portfolio_repository/i_portfolio_repo.dart' as _i11;
import '../repository/portfolio_repository/portfolio_repo.dart' as _i12;
import '../router/router.gr.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AppRouter>(() => appModule.appRouter);
  gh.singleton<_i15.SecureStorageManager>(appModule.secureStorage);
  gh.singleton<_i4.Dio>(appModule.dio);
  gh.singleton<_i5.DioClient>(appModule.dioClient);
  await gh.factoryAsync<_i6.FirebaseService>(() => appModule.fireService,
      preResolve: true);
  gh.factory<_i7.IMarketRepo>(() => _i8.MarketRepository(get<_i5.DioClient>()));
  gh.factory<_i9.INewsRepo>(() => _i10.NewsRepo(get<_i5.DioClient>()));
  gh.factory<_i11.IPortfolioRepo>(
      () => _i12.PortfolioRepository(get<_i5.DioClient>()));
  gh.factory<_i13.MarketBloc>(
      () => _i13.MarketBloc(marketRepository: get<_i7.IMarketRepo>()));
  gh.factory<_i14.PortfolioBloc>(() =>
      _i14.PortfolioBloc(portfolioRepository: get<_i11.IPortfolioRepo>()));

  gh.factory<_i16.TechnicalBloc>(
      () => _i16.TechnicalBloc(marketRepository: get<_i7.IMarketRepo>()));
  gh.factory<_i17.IAuthRepo>(() => _i18.AuthenRepository(
      get<_i5.DioClient>(), get<_i15.SecureStorageManager>()));
  gh.factory<_i19.AuthBloc>(
      () => _i19.AuthBloc(authRepo: get<_i17.IAuthRepo>()));
  gh.factory<_i20.LoginBloc>(() => _i20.LoginBloc(
      authRepo: get<_i17.IAuthRepo>(), authBloc: get<_i19.AuthBloc>()));
  return get;
}

class _$AppModule extends _i21.AppModule {}
