// abstract class AuthState extends Equatable {}

// class AuthInitial extends AuthState {
//   @override
//   List<Object> get props => [];
// }

// class Authenticating extends AuthState {
//   @override
//   List<Object> get props => [];
// }

// class Authenticated extends AuthState {
//   final String authToken;

//   Authenticated({required this.authToken});

//   @override
//   List<Object> get props => [authToken];
// }

// class AuthenError extends AuthState {
//   final String errMsg;

//   AuthenError({required this.errMsg});

//   @override
//   List<Object> get props => [errMsg];
// }

// class UnAuthenticated extends AuthState {
//   @override
//   List<Object> get props => [];
// }

import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/helpers/definitions.dart';

class AuthState {
  final String? authToken;
  final String message;
  BlocStateStatus status;

  AuthState({
    this.authToken,
    this.message = '',
    this.status = BlocStateStatus.initial,
  });
}
