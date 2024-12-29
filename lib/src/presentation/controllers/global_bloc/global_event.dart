part of 'global_bloc.dart';

abstract class GlobalEvent  {
  const GlobalEvent();

  
}

class GlobalNavigatorEvent extends GlobalEvent 
{
  final BuildContext buildContext;
  final String route;
  final int index;
  const GlobalNavigatorEvent({required this.buildContext,required this.route,required this.index});
  
  
}

class GlobalCategoryNavigatorEvent extends GlobalEvent

{
  final String title;
  const GlobalCategoryNavigatorEvent({required this.title});
}

class GlobalGetAllBrandsEvent extends GlobalEvent
{
  
}
class GlobalGetAllCarModelEvent extends GlobalEvent
{
  final DataMap? query;
  const GlobalGetAllCarModelEvent({ this.query});
}


class GlobalSelectBrandEvent extends GlobalEvent {
  final String brandId;

  GlobalSelectBrandEvent(this.brandId);
}

class GlobalSelectCarModelEvent extends GlobalEvent {
  final String carModelId;

  GlobalSelectCarModelEvent(this.carModelId);
}

class GlobalGetAllTagsEvent extends GlobalEvent {
  final DataMap? query;

  const GlobalGetAllTagsEvent({this.query});

  
}

class GlobalGetAllItemsEvent extends GlobalEvent {
  final DataMap? query;

  const GlobalGetAllItemsEvent({this.query});

  
}