part of 'global_bloc.dart';

 class GlobalState extends Equatable {
  final String routerName;
  final int indexPage;
  final String categoryTitile;
   const  GlobalState({
    this.indexPage = 0,
    this.routerName = 'home',
    this.categoryTitile = '',
  });

  
  @override
  List<Object> get props => [indexPage, routerName, categoryTitile];
  GlobalState copyWith({
    int? indexPage,
    String? routerName,
    String? categoryTitile,
    
  }) {
    return GlobalState(
      indexPage: indexPage ?? this.indexPage,
      routerName: routerName ?? this.routerName,
      categoryTitile: categoryTitile ?? this.categoryTitile,
    
    );
  }
}


