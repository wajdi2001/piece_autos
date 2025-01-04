part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboadChnageMenuEvent extends DashboardEvent {
  final String menu;

  const DashboadChnageMenuEvent({required this.menu});
  @override
  List<Object> get props => [menu];
}

class DashboardSelectImageEvent extends DashboardEvent {
  final Uint8List imageBytes;
  final String imageName;
  final String imageExtension;

  const DashboardSelectImageEvent({
    required this.imageBytes,
    required this.imageName,
    required this.imageExtension,
  });

  @override
  List<Object> get props => [imageBytes, imageName, imageExtension];
}

class DashboardUpsertBrandEvent extends DashboardEvent {
  final String? brandId;
  final String name;

  const DashboardUpsertBrandEvent({this.brandId, required this.name});
  @override
  List<Object> get props => [name];
}

class DashboardUpsertCarModelEvent extends DashboardEvent {
  final String? carModelId;
  final String name;
  final int yearOfConstruction;

  const DashboardUpsertCarModelEvent(
      {this.carModelId, required this.name, required this.yearOfConstruction});
  @override
  List<Object> get props => [name, yearOfConstruction];
}

class DashboardUpsertTvaModelEvent extends DashboardEvent {
  final String? tvaId;
  final String name;
  final double rate;

  const DashboardUpsertTvaModelEvent(
      {this.tvaId, required this.name, required this.rate});
  @override
  List<Object> get props => [name, rate];
}

class DashboardChangeSelectedBrandEvent extends DashboardEvent {
  final String? brandId;

  const DashboardChangeSelectedBrandEvent({required this.brandId});
}

class DashboardChangeSelectedBrandTypeEvent extends DashboardEvent {
  final BrandType brandTypeIndex;

  const DashboardChangeSelectedBrandTypeEvent({required this.brandTypeIndex});
}
