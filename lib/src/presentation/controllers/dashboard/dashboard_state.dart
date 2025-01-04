import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:piece_autos/src/domain/entities/brand.dart';

class DashboardState extends Equatable {
  final StateStatus status;
  final String currentMenu;
  final ImageData? imageData;
  final String? errorMsg;
  final String selectedBrandId;
  final BrandType selectedBrandType;

  const DashboardState({
    this.currentMenu = "Brand",
    this.imageData,
    this.status = StateStatus.initial,
    this.selectedBrandId = "NONE",
    this.errorMsg,
    this.selectedBrandType = BrandType.car,
  });

  @override
  List<Object?> get props => [
        currentMenu,
        imageData,
        status,
        selectedBrandId,
        selectedBrandType,
      ];

  DashboardState copyWith({
    String? currentMenu,
    ImageData? imageData,
    StateStatus? status,
    String? errorMsg,
    String? selectedBrandId,
    BrandType? brandType,
  }) {
    return DashboardState(
      currentMenu: currentMenu ?? this.currentMenu,
      imageData: imageData ?? this.imageData,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      selectedBrandType: brandType ?? selectedBrandType,
    );
  }
}

enum StateStatus { initial, loading, failed, succes }

class ImageData {
  final Uint8List data;
  final String name;
  final String extension;

  ImageData({required this.data, required this.name, required this.extension});
}
