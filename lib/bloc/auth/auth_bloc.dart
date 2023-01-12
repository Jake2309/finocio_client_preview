import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stockolio/bloc/auth/auth_event.dart';
import 'package:stockolio/bloc/auth/auth_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/repository/authen_repository/i_auth_repo.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthState()) {
    on<AppStated>((event, emit) async {
      emit(AuthState(status: BlocStateStatus.loading));
      try {
        // Authen user hien tai
        var authResult = await authRepo.authenUser();
        if (authResult.success) {
          emit(AuthState(
              authToken: authResult.data!, status: BlocStateStatus.success));
        } else {
          emit(AuthState(
              status: BlocStateStatus.failure, message: authResult.message!));
        }
      } catch (e) {
        emit(AuthState(status: BlocStateStatus.failure, message: e.toString()));
      }
    });
    on<UserLoggedIn>((event, emit) => emit(AuthState(
        authToken: event.authToken, status: BlocStateStatus.success)));
    on<LoginError>((event, emit) => emit(
        AuthState(message: event.errMsg, status: BlocStateStatus.failure)));
  }
}
