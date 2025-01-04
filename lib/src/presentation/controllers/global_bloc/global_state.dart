part of 'global_bloc.dart';

 class GlobalState extends Equatable {
  final String routerName;
  final int indexPage;
  final String categoryTitile;
  final List<BrandModel> brands;
  final String? selectedBrandId; // Currently selected brand
  final String? selectedCarModelId; // Currently selected car model
    final int? selectedYearOfConstruction; // Selected year of construction
    final String errorMessage;
    final bool isBrandsLoading;
  final bool isCarModelsLoading;
  final bool isYearsLoading;
  final List<TagModel> tags;
  final List<ItemModel> items;
  final bool isOpenedSearch;
  final List<OrderItemModel> shoppingCart;
  final List<TvaModel> tvas;

  final GlobalStatus status;
  final List<CarModelModel> carModels;
  final String selectedItemModelId;
   const  GlobalState({
    this.indexPage = 0,
    this.routerName = 'home',
    this.categoryTitile = '',
    this.brands = const [],
    this.status = GlobalStatus.initial,
    this.carModels = const [],
    this.selectedBrandId,
    this.selectedCarModelId,
    this.selectedYearOfConstruction,
    this.errorMessage = '',
    this.isBrandsLoading = false,
    this.isCarModelsLoading = false,
    this.isYearsLoading = false,
    this.tags = const [],
    this.items = const [],
    this.isOpenedSearch = false,
    this.selectedItemModelId='',
    this.shoppingCart = const [],
    this.tvas = const [],


 
  });

  
  @override
  List<Object> get props => [indexPage, routerName, categoryTitile, brands,status, carModels,isBrandsLoading,
        isCarModelsLoading,
        isYearsLoading, tags,items,isOpenedSearch,selectedItemModelId,shoppingCart,tvas ];
  GlobalState copyWith({
    int? indexPage,
    String? routerName,
    String? categoryTitile,
    List<BrandModel>? brands,
     GlobalStatus? status,
     List<CarModelModel>? carModels,
     String? selectedBrandId,
     String? selectedCarModelId,
      int? selectedYearOfConstruction,
      String? errorMessage,
       bool? isBrandsLoading,
    bool? isCarModelsLoading,
    bool? isYearsLoading,
    List<TagModel>? tags,
    List<ItemModel>? items,
    bool? isOpenedSearch,
    String? selectedItemModelId,
    List<OrderItemModel>? shoppingCart,
    List<TvaModel>? tvas,
    
    
  }) {
    return GlobalState(
      indexPage: indexPage ?? this.indexPage,
      routerName: routerName ?? this.routerName,
      categoryTitile: categoryTitile ?? this.categoryTitile,
      brands: brands ?? this.brands,
      status: status??this.status,
      carModels: carModels?? this.carModels,
      selectedBrandId: selectedBrandId?? this.selectedBrandId,
      selectedCarModelId: selectedCarModelId?? this.selectedCarModelId,
      selectedYearOfConstruction: selectedYearOfConstruction?? this.selectedYearOfConstruction,
      errorMessage: errorMessage?? this.errorMessage,
      isBrandsLoading: isBrandsLoading ?? this.isBrandsLoading,
      isCarModelsLoading: isCarModelsLoading ?? this.isCarModelsLoading,
      isYearsLoading: isYearsLoading ?? this.isYearsLoading,
      tags: tags?? this.tags,
      items: items?? this.items,
      isOpenedSearch: isOpenedSearch?? this.isOpenedSearch,
      selectedItemModelId: selectedItemModelId?? this.selectedItemModelId,
      shoppingCart: shoppingCart?? this.shoppingCart,
      tvas: tvas?? this.tvas,
    
    );
  }
}


