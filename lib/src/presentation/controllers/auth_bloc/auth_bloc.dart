import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/services/injection_container.dart';
import '../../../domain/usecases/auth_usesCases/sign_in_use_case.dart';
import '../../../domain/usecases/auth_usesCases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {
    });
    on<AuthSignupEvent>(_onSignupEvent);
    on<AuthLoginEvent>(_onLoginEvent);
  }

  FutureOr<void> _onSignupEvent(AuthSignupEvent event, Emitter<AuthState> emit) async{
    SignUpUseCase signUpUseCase = sl<SignUpUseCase>();
    DataMap dataMap = {
      "name": event.name,
      "email": event.email,
      "password": event.password,
      "phoneNumber": event.phoneNumber,
    };
    final result= await signUpUseCase(dataMap);
    result.fold((f) {
      emit(state.copyWith(status: AuthStatus.error, message: f.errorMessage));
    }, (r) {
      emit(state.copyWith(status: AuthStatus.loaded, message: "registre avec success"));
    }); 
  }

  FutureOr<void> _onLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit)async {
    SignInUseCase loginUseCase = sl<SignInUseCase>();
    DataMap dataMap = {
      "email": event.email,
      "password": event.password,
    };
    final result = await loginUseCase(dataMap);
    result.fold((f) {
      emit(state.copyWith(status: AuthStatus.error, message: f.errorMessage));
    }, (r) {
      final username =r["userName"];
      final email = r["email"];
      final token = r["token"];
      emit(state.copyWith(status: AuthStatus.loaded, username:  username, email: email, token: token));
      emit(state.copyWith(status: AuthStatus.loaded, message: "Connexion réussie"));
    });  }
  }

