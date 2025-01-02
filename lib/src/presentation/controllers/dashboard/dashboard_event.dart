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
