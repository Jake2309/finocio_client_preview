// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:stockolio/library/k_chart_library/renderer/base_chart_painter.dart';
import 'package:stockolio/model/authen/login_request.dart';
import 'package:stockolio/model/authen/register_request.dart';

abstract class LoginEvent extends Equatable {}

class LoginStated extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginWithEmailButtonClick extends LoginEvent {
  final String userName;
  final String password;

  LoginWithEmailButtonClick({required this.userName, required this.password});

  @override
  List<Object> get props => [userName, password];
}

class LoginWithGoogle extends LoginEvent {
  LoginWithGoogle();
  @override
  List<Object> get props => [];
}

class LoginWithFacebook extends LoginEvent {
  @override
  List<Object> get props => [];
}

class AnonymousLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginButtonClick extends LoginEvent {
  final LoginRequest request;
  LoginButtonClick({
    required this.request,
  });
  @override
  List<Object?> get props => [request];
}

class RegisterButtonClick extends LoginEvent {
  final RegisterRequest request;
  RegisterButtonClick({
    required this.request,
  });

  @override
  List<Object?> get props => [request];
}
