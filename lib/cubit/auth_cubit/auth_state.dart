import 'package:g_route/model/auth/login_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginModel user;

  AuthSuccess(this.user);
}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);
}
