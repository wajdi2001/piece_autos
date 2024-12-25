import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<GlobalEvent>((event, emit) {
     
    });
    on<GlobalNavigatorEvent>(_onNavigatorEvent);
    on<GlobalCategoryNavigatorEvent>(_onCategoryNavigatorEvent);
  }

  void _onNavigatorEvent(GlobalNavigatorEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(indexPage: event.index,routerName: event.route));
  }

  void _onCategoryNavigatorEvent(GlobalCategoryNavigatorEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(categoryTitile: event.title));
  }
}
