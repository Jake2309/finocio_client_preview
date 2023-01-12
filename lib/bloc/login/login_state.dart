// abstract class LoginState extends Equatable {}

// class LoginInitial extends LoginState {
//   @override
//   List<Object> get props => [];
// }

// class LoggingIn extends LoginState {
//   @override
//   List<Object> get props => [];
// }

// class GoogleLoggingIn extends LoginState {
//   @override
//   List<Object> get props => [];
// }

// class FacebookLoggingIn extends LoginState {
//   @override
//   List<Object> get props => [];
// }

// class LoggedIn extends LoginState {
//   @override
//   List<Object> get props => [];
// }

// class LoginFailure extends LoginState {
//   @override
//   List<Object> get props => [];
// }

import 'package:stockolio/bloc/state_status.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final String? source;
  final String message;
  BlocStateStatus status;

  LoginState(
      {this.source, this.message = '', this.status = BlocStateStatus.initial});
}
