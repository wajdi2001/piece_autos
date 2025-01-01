import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/cache_helper.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/data/models/car_model_model.dart';
import 'package:piece_autos/src/data/models/order_item_model.dart';

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
    on<GlobalSelectItemEvent>(_onSelectItemEvent);
    on<GlobalGetAllItemsAndTagsFromCacheEvent>(
        _onGetAllItemsAndTagsFromCacheEvent);
        on<GlobalAddToShoppingCartEvent>(_onAddToShoppingCartEvent);
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
      (brands) {
        List<BrandModel>brandsModel=brands
            .map((e) => BrandModel(id: e.id, image: e.image, name: e.name))
            .toList();

      CacheHelper.saveObjectList(
              key: "brands", toJson: (p0) => p0.toJson1(), value: brandsModel);
emit(state.copyWith(
        status: GlobalStatus.loaded,
        isBrandsLoading: false,
        brands:brandsModel,
      ));
      } ,
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

          List<CarModelModel>carModelsModels=carModels.map((e) {
              return CarModelModel(
                id: e.id,
                name: e.name,
                brandId: e.brandId,
                yearOfConstruction: e.yearOfConstruction,
              );
            }).toList();

      CacheHelper.saveObjectList(
              key: "carModels", toJson: (p0) => p0.toJson1(), value: carModelsModels);
          // Emit success state with transformed car models
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            carModels: carModelsModels,
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
        List<CarModelModel>carModelsModels=carModels.map((e) {
              return CarModelModel(
                id: e.id,
                name: e.name,
                brandId: e.brandId,
                yearOfConstruction: e.yearOfConstruction,
              );
            }).toList();

      CacheHelper.saveObjectList(
              key: "carModels", toJson: (p0) => p0.toJson1(), value: carModelsModels);
        emit(state.copyWith(
          isCarModelsLoading: false,
          carModels: carModelsModels,
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
          List<TagModel> tagsModel = tags.map((e) {
            return TagModel(
              id: e.id,
              name: e.name,
              imageUrl: e.imageUrl,
            );
          }).toList();
          CacheHelper.saveObjectList(
              key: "tags", toJson: (p0) => p0.toJson1(), value: tagsModel);

          // Emit success state with transformed tags
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            tags: tagsModel,
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
          List<ItemModel> itemsModel = items.map((e) {
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
          }).toList();
          CacheHelper.saveObjectList(
              key: "items", toJson: (p0) => p0.toJson1(), value: itemsModel);
          // Emit success state with transformed items
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            items: itemsModel,
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

  void _onSelectItemEvent(
      GlobalSelectItemEvent event, Emitter<GlobalState> emit) {
    CacheHelper.saveData(key: 'selectedItemModelId', value: event.itemId);
    emit(state.copyWith(selectedItemModelId: event.itemId));
  }

  void _onGetAllItemsAndTagsFromCacheEvent(
      GlobalGetAllItemsAndTagsFromCacheEvent event,
      Emitter<GlobalState> emit) async {
    emit(state.copyWith(status: GlobalStatus.loading)); // Emit loading state

    try {
      // Fetch items and tags from cache
      List<TagModel> tags = (await CacheHelper.getData(key: 'tags') as List)
          .map((tag) => TagModel.fromJson(tag))
          .toList();

      List<ItemModel> retrievedItems = CacheHelper.getObjectList(
        key: 'items',
        fromJson: (jsonString) => ItemModel.fromJson1(jsonString),
      );

      // Emit success state with updated items and tags
      emit(state.copyWith(
        status: GlobalStatus.loaded,
        items: retrievedItems,
        tags: tags,
      ));
    } catch (e) {
      // Emit error state on failure
      emit(state.copyWith(
        status: GlobalStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onAddToShoppingCartEvent(
      GlobalAddToShoppingCartEvent event,
      Emitter<GlobalState> emit) async {
    final List<OrderItemModel > newList=List.from(state.shoppingCart);
    newList.add(event.item);
    emit(state.copyWith(shoppingCart: newList));
}
}
