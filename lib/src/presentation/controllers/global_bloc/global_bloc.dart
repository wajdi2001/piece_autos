import 'dart:async';
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
import '../../../data/models/tva_model.dart';
import '../../../domain/usecases/brand_use_cases/get_all_brand.dart';
import '../../../domain/usecases/item_use_cases/get_all_tems.dart';
import '../../../domain/usecases/tag_use_cases/get_all_tags.dart';
import '../../../domain/usecases/tva_use_cases/get_all_tva.dart';

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
    on<GlobalCreateOrUpdateBrandEvent>(
      onCreateOrUpdateBrandEvent,
    );

    on<GlobalDeleteBrandEvent>(_onDeleteBrandModel);
    on<GlobalSelectItemEvent>(_onSelectItemEvent);
    on<GlobalGetAllItemsAndTagsFromCacheEvent>(
        _onGetAllItemsAndTagsFromCacheEvent);
        on<GlobalAddToShoppingCartEvent>(_onAddToShoppingCartEvent);
        on<GlobalUpdateShoppingCartEvent>(_onUpdateShoppingCartEvent);
        on<GlobalGetAllTVAEvent>(_onGetAllTVAEvent);

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

  var res = await sl<GetAllBrandsUseCase>()();

  res.fold(
    (failure) => emit(state.copyWith(isBrandsLoading: false)),
    (brands) {
      List<BrandModel> brandsModel = brands.map((e) {
        return BrandModel(id: e.id, image: e.image, name: e.name);
      }).toList();

      // Save to cache
      CacheHelper.saveObjectList(
        key: "brands",
        toJson: (p0) => p0.toJson1(),
        value: brandsModel,
      );

      // Update state
      emit(state.copyWith(
        status: GlobalStatus.loaded,
        isBrandsLoading: false,
        brands: brandsModel,
      ));
    },
  );
}

void _onGetAllCarModelEvent(
    GlobalGetAllCarModelEvent event, Emitter<GlobalState> emit) async {
  emit(state.copyWith(isCarModelsLoading: true));

  var res = await sl<GetAllCarModelsUseCase>()(event.query ?? {});

  res.fold(
    (failure) => emit(state.copyWith(
      status: GlobalStatus.error,
      errorMessage: failure.message,
      isCarModelsLoading: false,
    )),
    (carModels) {
      List<CarModelModel> carModelsModels = carModels.map((e) {
        return CarModelModel(
          id: e.id,
          name: e.name,
          brandId: e.brandId,
          yearOfConstruction: e.yearOfConstruction,
        );
      }).toList();

      // Save to cache
      CacheHelper.saveObjectList(
        key: "carModels",
        toJson: (p0) => p0.toJson1(),
        value: carModelsModels,
      );

      // Update state
      emit(state.copyWith(
        status: GlobalStatus.loaded,
        isCarModelsLoading: false,
        carModels: carModelsModels,
      ));
    },
  );
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

  // Fetch car models for the selected brand
  var query = {"brandId": event.brandId};
  var res = await sl<GetAllCarModelsUseCase>()(query);

  res.fold(
    (failure) {
      emit(state.copyWith(isCarModelsLoading: false));
    },
    (carModels) async{
      // Save to cache
      CacheHelper.saveData(key: "selectedBrandId", value: event.brandId);
      List<CarModelModel> carModelsModels = carModels.map((e) {
        return CarModelModel(
          id: e.id,
          name: e.name,
          brandId: e.brandId,
          yearOfConstruction: e.yearOfConstruction,
        );
      }).toList();
     
      // Update state
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

  try {
    

    final selectedCarModel = state.carModels.firstWhere(
      (carModel) => carModel.id == event.carModelId,
      orElse: () => throw Exception("Car model not found"),
    );

    // Save to cache
    CacheHelper.saveData(key: "selectedCarModelId", value: event.carModelId);
    // Update state
    emit(state.copyWith(
      isYearsLoading: false,
      selectedCarModelId: event.carModelId,
      selectedYearOfConstruction: selectedCarModel.yearOfConstruction,
    ));
  } catch (e) {
    emit(state.copyWith(
      isYearsLoading: false,
      status: GlobalStatus.error,
      errorMessage: e.toString(),
    ));
  }
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
              tvaRate: e.tvaRate,
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
        emit(state.copyWith(status: GlobalStatus.loading));
    CacheHelper.saveData(key: 'selectedItemModelId', value: event.itemId);
    emit(state.copyWith(selectedItemModelId: event.itemId,status: GlobalStatus.loaded));
  }

  void _onGetAllItemsAndTagsFromCacheEvent(
      GlobalGetAllItemsAndTagsFromCacheEvent event,
      Emitter<GlobalState> emit) async {
    emit(state.copyWith(status: GlobalStatus.loading)); // Emit loading state

    try {
      // Fetch items and tags from cache
      List<TagModel> tags = CacheHelper.getObjectList(
        key: 'tags',
        fromJson: (jsonString) => TagModel.fromJson1(jsonString),
      );

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
    bool success = false;
    for (var e in newList) {
      if(e.itemId==event.item.itemId)
      {

        OrderItemModel newItemModel =OrderItemModel(id: e.id, itemId: e.itemId, quantity: e.quantity+1);
        newList.remove(e);
        newList.add(newItemModel);
        success = true;
      }
    }
    if(!success){
      newList.add(event.item);
    }
    emit(state.copyWith(shoppingCart: newList));
}

  FutureOr<void> onCreateOrUpdateBrandEvent(
      GlobalCreateOrUpdateBrandEvent event, emit) async {
    emit(state.copyWith(status: GlobalStatus.loading));
    final indexOfBrandModel =
        state.brands.indexWhere((elt) => elt.id == event.id);
    if (indexOfBrandModel != -1) {
      BrandModel relatedBrand = state.brands[indexOfBrandModel];
      relatedBrand =
          relatedBrand.copyWith(name: event.name, image: event.imageUrl);
      final updatedList = List<BrandModel>.from(state.brands);
      updatedList[indexOfBrandModel] = relatedBrand;
      emit(state.copyWith(status: GlobalStatus.loaded, brands: updatedList));
    } else {
      var brandModel =
          BrandModel(id: event.id, name: event.name, image: event.imageUrl);
      final updatedList = List<BrandModel>.from(state.brands);
      updatedList.add(brandModel);
      emit(state.copyWith(status: GlobalStatus.loaded, brands: updatedList));
    }
  }

  void _onUpdateShoppingCartEvent(
      GlobalUpdateShoppingCartEvent event,
      Emitter<GlobalState> emit) async {
        List<OrderItemModel> newList = List.from(state.shoppingCart);
        if(event.remove)
        {
          newList.removeWhere((elt) => elt.itemId == event.item.itemId);
        }else{
          int index = newList.indexWhere((elt) => elt.itemId == event.item.itemId);
        if (index != -1) {
          newList[index] = event.item;
        }
        }
        
        emit(state.copyWith(shoppingCart: newList));
    
  }

  void _onGetAllTVAEvent(GlobalGetAllTVAEvent event, Emitter<GlobalState> emit)async{
    emit(state.copyWith(status: GlobalStatus.loading));
    final getAllTVAUseCase = sl<GetAllTVAsUseCase>();
    final res = await getAllTVAUseCase();

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
          List<TvaModel> tvasModel = items.map((e) {
            return TvaModel(
              id: e.id,
              name: e.name,
              percentage: e.percentage,
            );
          }).toList();
          
          // Emit success state with transformed items
          emit(state.copyWith(
            status: GlobalStatus.loaded,
            tvas: tvasModel,
          ));
        },
        );

  }
}
