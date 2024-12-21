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
