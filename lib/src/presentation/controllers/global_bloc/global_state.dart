part of 'global_bloc.dart';

 class GlobalState extends Equatable {
  final String routerName;
  final int indexPage;
   const  GlobalState({
    this.indexPage = 0,
    this.routerName = 'home',
  });

  
  @override
  List<Object> get props => [indexPage, routerName];
  GlobalState copyWith({
    int? indexPage,
    String? routerName,
    
  }) {
    return GlobalState(
      indexPage: indexPage ?? this.indexPage,
      routerName: routerName ?? this.routerName,
    
    );
  }
}


