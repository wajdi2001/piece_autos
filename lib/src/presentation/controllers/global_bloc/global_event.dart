part of 'global_bloc.dart';

abstract class GlobalEvent {
  const GlobalEvent();
}

class GlobalNavigatorEvent extends GlobalEvent {
  final BuildContext buildContext;
  final String route;
  final int index;
  const GlobalNavigatorEvent(
      {required this.buildContext, required this.route, required this.index});
}

class GlobalCategoryNavigatorEvent extends GlobalEvent {
  final String title;
  const GlobalCategoryNavigatorEvent({required this.title});
}

class GlobalGetAllBrandsEvent extends GlobalEvent {}

class GlobalGetAllCarModelEvent extends GlobalEvent {
  final DataMap? query;
  const GlobalGetAllCarModelEvent({this.query});
}

class GlobalSelectBrandEvent extends GlobalEvent {
  final String brandId;

  GlobalSelectBrandEvent(this.brandId);
}

class GlobalSelectCarModelEvent extends GlobalEvent {
  final String carModelId;

  GlobalSelectCarModelEvent(this.carModelId);
}

class GlobalDeleteBrandEvent extends GlobalEvent {
  final String brandId;

  GlobalDeleteBrandEvent({required this.brandId});
}

class GlobalDeleteTvaEvent extends GlobalEvent {
  final String tvaId;

  GlobalDeleteTvaEvent({required this.tvaId});
}

class GlobalDeleteCarModelEvent extends GlobalEvent {
  final String carModelId;

  GlobalDeleteCarModelEvent({required this.carModelId});
}

class GlobalGetAllTagsEvent extends GlobalEvent {
  final DataMap? query;

  const GlobalGetAllTagsEvent({this.query});
}

class GlobalGetAllItemsEvent extends GlobalEvent {
  final DataMap? query;

  const GlobalGetAllItemsEvent({this.query});
}

class GlobalSwitchSearchBarEvent extends GlobalEvent {
  final bool show;
  const GlobalSwitchSearchBarEvent({required this.show});
}

class GlobalSelectItemEvent extends GlobalEvent {
  final String itemId;
  const GlobalSelectItemEvent({required this.itemId});
}

class GlobalGetAllItemsAndTagsFromCacheEvent extends GlobalEvent {
  const GlobalGetAllItemsAndTagsFromCacheEvent();
}

class GlobalAddToShoppingCartEvent extends GlobalEvent {
  final OrderItemModel item;
  const GlobalAddToShoppingCartEvent({required this.item});
}

class GlobalCreateOrUpdateBrandEvent extends GlobalEvent {
  final BrandModel brandModel;

  GlobalCreateOrUpdateBrandEvent({
    required this.brandModel,
  });
}

class GlobalCreateOrUpdateCarModelEvent extends GlobalEvent {
  final DataCarModel carModel;

  GlobalCreateOrUpdateCarModelEvent({required this.carModel});
}

class GlobalCreateOrUpdateTvaModelEvent extends GlobalEvent {
  final TvaModel tvaModel;
  GlobalCreateOrUpdateTvaModelEvent({required this.tvaModel});
}

class GlobalUpdateShoppingCartEvent extends GlobalEvent {
  final OrderItemModel item;
  final bool remove;
  const GlobalUpdateShoppingCartEvent(
      {required this.item, required this.remove});
}

class GlobalGetAllTVAEvent extends GlobalEvent {}
