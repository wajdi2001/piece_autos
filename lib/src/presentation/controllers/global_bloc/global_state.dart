part of 'global_bloc.dart';

 class GlobalState extends Equatable {
  final String routerName;
  final int indexPage;
  final String categoryTitile;
  final List<BrandModel> brands;
   const  GlobalState({
    this.indexPage = 0,
    this.routerName = 'home',
    this.categoryTitile = '',
    this.brands = const [],
 
  });

  
  @override
  List<Object> get props => [indexPage, routerName, categoryTitile, brands];
  GlobalState copyWith({
    int? indexPage,
    String? routerName,
    String? categoryTitile,
    List<BrandModel>? brands,
    
  }) {
    return GlobalState(
      indexPage: indexPage ?? this.indexPage,
      routerName: routerName ?? this.routerName,
      categoryTitile: categoryTitile ?? this.categoryTitile,
      brands: brands ?? this.brands,
    
    );
  }
}


