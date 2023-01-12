import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/repository/authen_repository/authen_repo.dart';
import 'package:stockolio/repository/authen_repository/i_auth_repo.dart';
import 'package:stockolio/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      // the navigation is paused until resolver.next() is called with either
      // true to resume/continue navigation or false to abort navigation
      var token = await getIt<SecureStorageManager>()
          .readKey(Preferences.auth_token) as String;
      // var result = await getIt<IAuthRepo>().authenUser();
      if (token.isNotEmpty) {
        // if (true) {
        resolver.next(true);
      } else {
        // we redirect the user to our login page
        router.push(
          LoginRoute(),
        );
      }
    } catch (e) {
      // we redirect the user to our login page
      router.push(
        LoginRoute(),
      );
    }
  }
}
