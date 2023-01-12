// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/helpers/device_manager.dart';
import 'package:stockolio/helpers/response_code.dart';
import 'package:stockolio/helpers/result.dart';
import 'package:stockolio/helpers/server_define.dart';
import 'package:stockolio/helpers/shared_preference_helper.dart';
import 'package:stockolio/helpers/secure_storage_manager.dart';
import 'package:stockolio/model/authen/register_request.dart';
import 'package:stockolio/model/authen/login_request.dart';
import 'package:stockolio/model/authen/social_login_request.dart';
import 'package:stockolio/model/device/device_info.dart';
import 'package:stockolio/model/portfolio/sync_portfolio_request.dart';
import 'package:stockolio/network/dio_client.dart';
import 'package:stockolio/repository/authen_repository/i_auth_repo.dart';

@Injectable(as: IAuthRepo)
class AuthenRepository implements IAuthRepo {
  final SecureStorageManager _secureStorageManager;
  final DioClient _dioClient;

  AuthenRepository(this._dioClient, this._secureStorageManager);
  @override
  Future<Result<String>> authenUser() async {
    try {
      var responseMap =
          await _dioClient.get(ServerUri.FINO_API + '/api/auth/authen-user');

      Result<String> result = Result.fromJson(responseMap);

      if (result.code == HttpStatus.ok) {
        await _secureStorageManager.saveKey(
            Preferences.auth_token, responseMap['data']);

        result.data = responseMap['data'];

        return result;
      } else {
        print('authenUser Error: ${json.encode(responseMap)}');
      }
    } catch (e) {
      print(e.toString());

      return Result<String>(
          success: false, code: ResponseCode.SYS_GENERIC_ERROR);
    }

    return Result<String>(success: false, code: ResponseCode.UNAUTHORIZED);
  }

  @override
  Future<Result<String>> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    late User user;

    if (auth.currentUser != null) {
      user = auth.currentUser!;

      // luu thong tin token vao bo nho may
      // SecureStorageManager.saveKey(Preferences.auth_token, user.refreshToken);
      return new Result(data: user.refreshToken);
    }

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential).timeout(
                  const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
                );

        user = userCredential.user!;

        DeviceInfo? deviceInfo = await DeviceManager.getDeviceInfo();
        // Sau khi user dang nhap voi tai khoan social network
        // tam thoi truyen tham so len de tao fino user va dong bo vao server
        // chua biet lam tnao ngon hon, nghien cuu sau
        var request = new SocialLoginRequest(
          uid: user.uid,
          name: user.displayName!,
          deviceKey: deviceInfo!.id,
          socialRefreshToken: user.refreshToken!,
          email: user.email!,
        );

        Result<String> authToken = await signinWithSocialAccount(request);
        if (authToken.success) {
          _secureStorageManager.saveKey(Preferences.auth_token, authToken.data);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          return Result(
              success: false,
              code:
                  ResponseCode.GOOGLE_ACCOUNT_EXIST_WITH_DIFFERENCE_CREDENTICAL,
              message: 'Tai khoan da ton tai');
        } else if (e.code == 'invalid-credential') {
          return Result(
              success: false,
              code: ResponseCode.GOOGLE_ACCOUNT_INVALID_CREDENTICAL,
              message: 'Tai khoan khong ton tai');
        }
      } on TimeoutException catch (e) {
        print(e.toString());
        return new Result(code: ResponseCode.TIMEOUT);
      } catch (e) {
        print(e.toString());
        return new Result(
            success: false,
            code: ResponseCode.UNKNOW_ERROR,
            message: 'System error!! Authen Google failure!');
      }
    }

    return Result(data: user.refreshToken);
  }

  @override
  Future<Result<String>> anonymousSignin() async {
    try {
      DeviceInfo? deviceInfo = await DeviceManager.getDeviceInfo();

      // Uri path = Uri.parse(
      //     ServerUri.FINO_API + '/api/auth/anonymous-login/${deviceInfo!.id}');

      // var dioClient = await getIt.getAsync<DioClient>();
      var responseMap = await _dioClient.get(
          ServerUri.FINO_API + '/api/auth/anonymous-login/${deviceInfo!.id}');

      // print(response);

      Result<String> result = Result.fromJson(responseMap);

      // var sharePreference = await getIt.getAsync<SharedPreferenceHelper>();

      if (result.code == HttpStatus.ok) {
        // _sharedPreferenceHelper.saveAuthToken(responseMap['data']);
        _secureStorageManager.saveKey(
            Preferences.auth_token, responseMap['data']);

        result.data = responseMap['data'];

        return result;
      } else {
        print('anonymousSignin Error: ${json.encode(responseMap)}');
      }

      // var response = await HttpHelper.anonymousGet(path);
      // if (response.statusCode == HttpStatus.ok) {
      //   var token = jsonDecode(response.body)['data'];

      //   SecureStorageManager.saveKey(Preferences.auth_token, token);

      //   return new Result<String>(data: token);
      // } else {
      //   print('anonymousSignin Error: ${response}');
      // }

      return Result(
        success: false,
        code: ResponseCode.UNKNOW_ERROR,
        message: 'Login anonymous error!!!',
      );
    } on TimeoutException catch (e) {
      print(e.toString());
      return new Result(
        success: false,
        code: ResponseCode.TIMEOUT,
      );
    } catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.SYS_GENERIC_ERROR,
      );
    }
  }

  @override
  Future<Result<String>> signinWithSocialAccount(
      SocialLoginRequest request) async {
    try {
      Uri path = Uri.parse(ServerUri.FINO_API + '/api/auth/social-login');

      var response = await http
          .post(
            path,
            headers: {"Content-type": "application/json"},
            body: request.toJson(),
          )
          .timeout(
            const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
          );
      if (response.statusCode == HttpStatus.ok) {
        var resMap = jsonDecode(response.body);

        var result = Result<String>.fromJson(resMap);
        result.data = resMap['data'];

        return result;
      } else {
        print('signinWithSocialAccount error!!!!');

        return Result(
          success: false,
          code: ResponseCode.UNKNOW_ERROR,
          message: response.body,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.TIMEOUT,
      );
    } on Error catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.SYS_GENERIC_ERROR,
      );
    }
  }

  @override
  Future<Result<User>> getCurrentFirebaseInfo() async {
    try {
      var auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        var user = auth.currentUser;

        String? token =
            await _secureStorageManager.readKey(Preferences.auth_token);
        if (token == null || token.isEmpty) {
          DeviceInfo? deviceInfo = await DeviceManager.getDeviceInfo();

          Uri path =
              Uri.parse(ServerUri.FINO_API + '/api/portfolio/sync-portfolio');

          var request = new SyncPortfolioRequest(
            uid: user!.uid,
            oldIdentification: deviceInfo!.id,
          );

          Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          };

          var bodyRequest = json.encode(request.toJson());

          var response = await http
              .post(
                path,
                headers: headers,
                body: bodyRequest,
              )
              .timeout(
                const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
              );

          if (response.statusCode == HttpStatus.ok) {
            var responseMap = jsonDecode(response.body);

            var result = Result<User>.fromJson(responseMap);
            result.data = user;

            return result;
          } else {
            print('getCurrentFirebaseInfo error: ${response.body}');

            return Result(
              success: false,
              code: ResponseCode.UNKNOW_ERROR,
              message: response.body,
            );
          }
        }

        return new Result(data: user);
      }

      return new Result(success: false);
    } on TimeoutException catch (e) {
      print(e.toString());

      return new Result(
        success: false,
        code: ResponseCode.TIMEOUT,
      );
    } catch (e) {
      print(e.toString());

      return new Result(
        success: false,
        code: ResponseCode.SYS_GENERIC_ERROR,
      );
    }
  }

  @override
  Future<Result<String>> login(LoginRequest request) async {
    try {
      Uri path = Uri.parse(ServerUri.FINO_API + '/api/auth/login-user');

      var response = await http
          .post(
            path,
            headers: {"Content-type": "application/json"},
            body: request.toJson(),
          )
          .timeout(
            const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
          );

      // print(json.encode(response));
      if (response.statusCode == HttpStatus.ok) {
        var resMap = jsonDecode(response.body);

        var result = Result<String>.fromJson(resMap);
        result.data = resMap['data'];

        return result;
      } else {
        print('login error!!!!');

        return Result(
          success: false,
          code: ResponseCode.UNKNOW_ERROR,
          message: response.body,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.TIMEOUT,
      );
    } on Error catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.SYS_GENERIC_ERROR,
      );
    }
  }

  @override
  Future<Result<String>> register(RegisterRequest request) async {
    try {
      Uri path = Uri.parse(ServerUri.FINO_API + '/api/auth/register-user');

      var response = await http
          .post(
            path,
            headers: {"Content-type": "application/json"},
            body: request.toJson(),
          )
          .timeout(
            const Duration(seconds: Definition.HTTP_REQUEST_TIMEOUT),
          );
      if (response.statusCode == HttpStatus.ok) {
        var resMap = jsonDecode(response.body);

        var result = Result<String>.fromJson(resMap);
        result.data = resMap['data'];

        return result;
      } else {
        print('register error!!!!');

        return Result(
          success: false,
          code: ResponseCode.UNKNOW_ERROR,
          message: response.body,
        );
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.TIMEOUT,
      );
    } on Error catch (e) {
      print(e.toString());
      return Result(
        success: false,
        code: ResponseCode.SYS_GENERIC_ERROR,
      );
    }
  }
}
