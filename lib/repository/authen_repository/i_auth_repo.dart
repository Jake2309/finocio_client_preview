import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/model/authen/login_request.dart';
import 'package:stockolio/model/authen/register_request.dart';
import 'package:stockolio/model/authen/social_login_request.dart';

abstract class IAuthRepo {
  Future<Result<String>> authenUser();
  Future<Result<String>> signInWithGoogle();
  Future<Result<String>> anonymousSignin();
  Future<Result<String>> login(LoginRequest request);
  Future<Result<String>> register(RegisterRequest request);
  Future<Result<String>> signinWithSocialAccount(SocialLoginRequest request);
  Future<Result<User>> getCurrentFirebaseInfo();
}
