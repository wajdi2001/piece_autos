import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/data/models/car_model_model.dart';

import 'package:piece_autos/src/domain/usecases/brand_use_cases/delete_brand.dart';

import 'package:piece_autos/src/data/models/tag_model.dart';

import 'package:piece_autos/src/domain/usecases/car_model_use_cases/ger_all_car_models.dart';

import '../../../../core/services/enums.dart';
import '../../../../core/services/injection_container.dart';
import '../../../data/models/item_model.dart';
import '../../../domain/usecases/brand_use_cases/get_all_brand.dart';
import '../../../domain/usecases/item_use_cases/get_all_tems.dart';
import '../../../domain/usecases/tag_use_cases/get_all_tags.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  static GlobalBloc get(context) => BlocProvider.of(context);
  GlobalBloc() : super(GlobalState()) {
    on<GlobalEvent>((event, emit) {});
    on<GlobalNavigatorEvent>(_onNavigatorEvent);
    on<GlobalCategoryNavigatorEvent>(_onCategoryNavigatorEvent);
    on<GlobalGetAllBrandsEvent>(_onGetAllBrandsEvent);
    on<GlobalGetAllCarModelEvent>(_onGetAllCarModelEvent);
    on<GlobalSelectBrandEvent>(_onSelectBrand);
    on<GlobalSelectCarModelEvent>(_onSelectCarModel);
    on<GlobalGetAllTagsEvent>(_onGetAllTagsEvent);
    on<GlobalGetAllItemsEvent>(_onGetAllItemsEvent);
    on<GlobalSwitchSearchBarEvent>(_onSwitchSearchBarEvent);

 
    on<GlobalDeleteBrandEvent>(_onDeleteBrandModel);




  }

  void _onNavigatorEvent(
      GlobalNavigatorEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(indexPage: event.index, routerName: event.route));
  }

  void _onCategoryNavigatorEvent(
      GlobalCategoryNavigatorEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(categoryTitile: event.title));
  }

  void _onGetAllBrandsEvent(
      GlobalGetAllBrandsEvent event, Emitter<GlobalState> emit) async {
    emit(state.copyWith(isBrandsLoading: true));

    GetAllBrandsUseCase getAllBrands = sl<GetAllBrandsUseCase>();
    var res = await getAllBrands();

    res.fold(
      (failure) => emit(state.copyWith(isBrandsLoading: false)),
      (brands) => emit(state.copyWith(

        status: GlobalStatus.loaded,
        isBrandsLoading: false,
        brands: brands
            .map((e) => BrandModel(id: e.id, image: e.image, name: e.name))
            .toList(),
      )),
    );
  }

  void _onGetAllCarModelEvent(
      GlobalGetAllCarModelEvent event, Emitter<GlobalState> emit) async {
    final getAllCarModel = sl<GetAllCarModelsUseCase>();

    try {
      // Ensure query is not null, pass empty map if null
      final query = event.query ?? {};

      // Fetch data using the use case
      final res = await getAllCarModel(query);

      // Handle the result using fold
      res.fold(
        (failure) {
          // Emit failure state
          emit(state.copyWith(
            status: GlobalStatus.error,
            errorMessage: failure.message,
          ));
        },
        (carModels) {
          // Emit success state with transformed car models
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            carModels: carModels.map((e) {
              return CarModelModel(
                id: e.id,
                name: e.name,
                brandId: e.brandId,
                yearOfConstruction: e.yearOfConstruction,
              );
            }).toList(),
          ));
        },
      );
    } catch (e) {
      // Catch unexpected errors and emit error state
      emit(state.copyWith(
        status: GlobalStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSelectBrand(
      GlobalSelectBrandEvent event, Emitter<GlobalState> emit) async {
    emit(state.copyWith(
      isCarModelsLoading: true,
      selectedBrandId: event.brandId,
      carModels: [],
      selectedCarModelId: null,
      selectedYearOfConstruction: null,
    ));

    GetAllCarModelsUseCase getAllCarModels = sl<GetAllCarModelsUseCase>();
    var query = {"brandId": event.brandId};
    var res = await getAllCarModels(query);

    res.fold(
      (failure) {
        emit(state.copyWith(isCarModelsLoading: false));
      },
      (carModels) {
        emit(state.copyWith(
          isCarModelsLoading: false,
          carModels: carModels
              .map((e) => CarModelModel(
                    id: e.id,
                    name: e.name,
                    brandId: e.brandId,
                    yearOfConstruction: e.yearOfConstruction,
                  ))
              .toList(),
        ));
      },
    );
  }

  void _onSelectCarModel(
      GlobalSelectCarModelEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(
      isYearsLoading: true,
    ));
    final selectedCarModel = state.carModels.firstWhere(
      (carModel) => carModel.id == event.carModelId,
      orElse: () => throw Exception("Car model not found"),
    );

    emit(state.copyWith(
      isYearsLoading: false,
      selectedCarModelId: event.carModelId,
      selectedYearOfConstruction: selectedCarModel.yearOfConstruction,
    ));
  }




  void _onDeleteBrandModel(
      GlobalDeleteBrandEvent event, Emitter<GlobalState> emit) async {
    final deleteBrandUserCase = sl<DeleteBrandUseCase>();
    emit(state.copyWith(status: GlobalStatus.loading));
    var result = await deleteBrandUserCase(event.brandId);
    result.fold((f) {
      emit(state.copyWith(
          status: GlobalStatus.error, errorMessage: f.errorMessage));
    }, (hasBeenDeleted) {
      if (hasBeenDeleted) {
        final updatedBrands =
            state.brands.where((x) => x.id != event.brandId).toList();
        emit(
            state.copyWith(brands: updatedBrands, status: GlobalStatus.loaded));
      }
    });
  }

       
void _onGetAllTagsEvent(
      GlobalGetAllTagsEvent event, Emitter<GlobalState> emit) async {
    final getAllTagsUseCase = sl<GetAllTagsUseCase>();

    try {
      // Emit loading state
      emit(state.copyWith(status: GlobalStatus.loading));

      // Ensure query is not null, pass empty map if null
      final query = event.query ?? {};

      // Fetch data using the use case
      final res = await getAllTagsUseCase(query);

      // Handle the result using fold
      res.fold(
        (failure) {
          // Emit failure state
          emit(state.copyWith(
            status: GlobalStatus.error,
            errorMessage: failure.message,
          ));
        },
        (tags) {
          // Emit success state with transformed tags
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            tags: tags.map((e) {
              return TagModel(
                id: e.id,
                name: e.name,
                imageUrl: e.imageUrl,
              );
            }).toList(),
          ));
        },
      );
    } catch (e) {
      // Catch unexpected errors and emit error state
      emit(state.copyWith(
        status: GlobalStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onGetAllItemsEvent(
      GlobalGetAllItemsEvent event, Emitter<GlobalState> emit) async {
    final getAllItemsUseCase = sl<GetAllItemsUseCase>();

    try {
      // Emit loading state
      emit(state.copyWith(status: GlobalStatus.loading));

      // Ensure query is not null, pass empty map if null
      final query = event.query ?? {};

      // Fetch data using the use case
      final res = await getAllItemsUseCase(query);

      // Handle the result using fold
      res.fold(
        (failure) {
          // Emit failure state
          emit(state.copyWith(
            status: GlobalStatus.error,
            errorMessage: failure.message,
          ));
        },
        (items) {
          // Emit success state with transformed items
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            items: items.map((e) {
              return ItemModel(
                id: e.id,
                name: e.name,
                description: e.description,
                images: e.images,
                brandId: e.brandId,
                hasDiscount: e.hasDiscount,
                price: e.price,
                quantity: e.quantity,
                ref: e.ref,
                status: e.status,
                tvaId: e.tvaId,
                tags: e.tags,
              );
            }).toList(),
          ));
        },
      );
    } catch (e) {
      // Catch unexpected errors and emit error state
      emit(state.copyWith(
        status: GlobalStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSwitchSearchBarEvent(
      GlobalSwitchSearchBarEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(isOpenedSearch: event.show));
  }
}
