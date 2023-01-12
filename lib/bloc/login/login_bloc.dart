import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stockolio/bloc/auth/auth_bloc.dart';
import 'package:stockolio/bloc/auth/auth_event.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/repository/authen_repository/i_auth_repo.dart';

import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // final AuthenRepository authRepo;
  final IAuthRepo authRepo;
  final AuthBloc authBloc;

  LoginBloc({required this.authRepo, required this.authBloc})
      : super(LoginState()) {
    on<LoginWithGoogle>((event, emit) async {
      emit(LoginState(
          status: BlocStateStatus.loading, source: LoginSource.GOOGLE));
      try {
        var userResult = await authRepo.signInWithGoogle();

        if (userResult.success) {
          authBloc.add(UserLoggedIn(authToken: userResult.data!));
          emit(LoginState(
              status: BlocStateStatus.success, source: LoginSource.GOOGLE));
        } else {
          authBloc.add(LoginError(errMsg: userResult.message!));
        }
      } catch (e) {
        authBloc.add(LoginError(errMsg: e.toString()));
      }
    });
    on<AnonymousLogin>((event, emit) async {
      emit(LoginState(status: BlocStateStatus.loading));

      // emit(LoginState(status: BlocStateStatus.success));
      // authBloc.add(UserLoggedIn(authToken: '123456'));

      var loginResult = await authRepo.anonymousSignin();
      if (loginResult.success) {
        authBloc.add(UserLoggedIn(authToken: loginResult.data!));
        emit(LoginState(
            status: BlocStateStatus.success, source: LoginSource.ANONYMOUS));
      } else {
        emit(LoginState(
            status: BlocStateStatus.failure, message: loginResult.message!));
      }
    });
    on<LoginButtonClick>(
      (event, emit) async {
        var loginResult = await authRepo.login(event.request);

        if (loginResult.success) {
          authBloc.add(UserLoggedIn(authToken: loginResult.data!));
          emit(LoginState(
              status: BlocStateStatus.success, source: LoginSource.APP));
        } else {
          emit(LoginState(
              status: BlocStateStatus.failure, message: loginResult.message!));
        }
      },
    );
    on<RegisterButtonClick>(
      (event, emit) async {
        var registerResult = await authRepo.register(event.request);

        if (registerResult.success) {
          authBloc.add(UserLoggedIn(authToken: registerResult.data!));
          emit(LoginState(
              status: BlocStateStatus.success, source: LoginSource.APP));
        } else {
          emit(LoginState(
              status: BlocStateStatus.failure,
              message: registerResult.message!));
        }
      },
    );
  }
}
