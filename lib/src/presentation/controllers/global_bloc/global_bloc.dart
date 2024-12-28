import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:piece_autos/src/data/datasources/remote/brand_remote_data_source/brand_remote_data_source.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/data/repositories/brand_repo_impl/brand_repo_impl.dart';

import '../../../../core/services/injection_container.dart';
import '../../../domain/usecases/brand_use_cases/get_all_brand.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<GlobalEvent>((event, emit) {
     
    });
    on<GlobalNavigatorEvent>(_onNavigatorEvent);
    on<GlobalCategoryNavigatorEvent>(_onCategoryNavigatorEvent);
    on<GlobalGetAllBrandsEvent>(_onGetAllBrandsEvent);
  }

  void _onNavigatorEvent(GlobalNavigatorEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(indexPage: event.index,routerName: event.route));
  }

  void _onCategoryNavigatorEvent(GlobalCategoryNavigatorEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(categoryTitile: event.title));
  }
  
  void _onGetAllBrandsEvent(GlobalGetAllBrandsEvent event, Emitter<GlobalState> emit) async{
   GetAllBrandsUseCase getAllBrands =sl<GetAllBrandsUseCase>();
    var res = await getAllBrands();
    
    
    res.fold((l) => null, 
    
    
    (r) =>emit(state.copyWith(brands: r.map(
        (e) => BrandModel(id: e.id,image: e.image,name: e.name)).toList())));
    


  }
}
