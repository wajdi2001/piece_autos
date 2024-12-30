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

  const DashboardSelectImageEvent({required this.imageBytes});

  @override
  List<Object> get props => [imageBytes];
}

class DashboardUpsertBrandEvent extends DashboardEvent {
  final String? brandId;
  final String name;

  const DashboardUpsertBrandEvent({this.brandId, required this.name});
  @override
  List<Object> get props => [name];
}
