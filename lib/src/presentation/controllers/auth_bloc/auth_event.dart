part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AuthSignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  const AuthSignupEvent({required this.email, required this.password, required this.name, required this.phoneNumber});

  @override
  List<Object> get props => [email, password, name, phoneNumber];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;
  const AuthLoginEvent({required this.email, required this.password, required this.rememberMe});
  @override
  List<Object> get props => [email, password, rememberMe];
}