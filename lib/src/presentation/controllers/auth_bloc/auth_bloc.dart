import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/services/injection_container.dart';
import '../../../domain/usecases/auth_usesCases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {
    });
    on<AuthSignupEvent>(_onSignupEvent);
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
}
