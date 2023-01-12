import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockolio/bloc/auth/auth_common.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/helpers/shared_preference_helper.dart';
import 'package:stockolio/network/dio_client.dart';
import 'package:stockolio/network/firebase_service.dart';
import 'package:stockolio/network/local_module.dart';
import 'package:stockolio/network/network_module.dart';
import 'package:stockolio/repository/authen_repository/authen_repo.dart';
import 'package:stockolio/router/auth_guard.dart';
import 'package:stockolio/router/router.gr.dart';

import 'repository/authen_repository/i_auth_repo.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

  // @injectable
  // FirebaseFirestore get store => FirebaseFirestore.instance;

  // @injectable
  // FirebaseAuth get auth => FirebaseAuth.instance;
  // @lazySingleton
  // Dio get dio => Dio();

  // @preResolve
  // Future<SharedPreferences> get sharePreference =>
  //     SharedPreferences.getInstance();

  // @singleton
  // FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();

  @injectable
  AppRouter get appRouter => AppRouter(authGuard: AuthGuard());

  @singleton
  SecureStorageManager get secureStorage =>
      SecureStorageManager(FlutterSecureStorage());

  @singleton
  Dio get dio => NetworkModule.provideDio(getIt<SecureStorageManager>());

  @singleton
  DioClient get dioClient => DioClient(getIt<Dio>());
}
