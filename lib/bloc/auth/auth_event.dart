import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {}

class AppStated extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UserLoggedIn extends AuthEvent {
  final String authToken;
  UserLoggedIn({required this.authToken});
  @override
  List<Object> get props => [authToken];
}

class LoginError extends AuthEvent {
  final String errMsg;
  LoginError({required this.errMsg});
  @override
  List<Object> get props => [errMsg];
}

class SocialAuthen extends AuthEvent {
  final String accountType;

  SocialAuthen({required this.accountType});

  @override
  List<Object> get props => [accountType];
}

class AuthenticationStateChanged extends AuthEvent {
  @override
  List<Object> get props => [];
}
