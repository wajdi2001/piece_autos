// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final AuthStatus status;
  final String message;
  const AuthState(
      {this.email = "",
      this.password = "",
      this.status = AuthStatus.initial,
      this.message = ""
      });

  
  @override
  List<Object> get props => [email, password,status, message];

  

  AuthState copyWith({
    String? email,
    String? password,
    AuthStatus? status,
    String? message
  }) {
    return AuthState(
      
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        message: message ?? this.message,
      
    );
  }
}


