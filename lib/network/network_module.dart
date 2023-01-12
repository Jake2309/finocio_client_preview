import 'package:dio/dio.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/helpers/shared_preference_helper.dart';

import 'end_point.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SecureStorageManager secureStorageManager) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            //getting token
            var token =
                await secureStorageManager.readKey(Preferences.auth_token);

            if (token != null) {
              options.headers
                  .putIfAbsent('Authorization', () => 'Bearer $token');
            } else {
              print('Auth token is null');
            }

            return handler.next(options);
          },
        ),
      );

    return dio;
  }
}
