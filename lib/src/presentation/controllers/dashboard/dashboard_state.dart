import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final StateStatus status;
  final String currentMenu;
  final ImageData? imageData;
  final String? errorMsg;

  const DashboardState(
      {this.currentMenu = "Brand",
      this.imageData,
      this.status = StateStatus.initial,
      this.errorMsg});

  @override
  List<Object?> get props => [
        currentMenu,
        imageData,
        status,
      ];

  DashboardState copyWith(
      {String? currentMenu,
      ImageData? imageData,
      StateStatus? status,
      String? errorMsg}) {
    return DashboardState(
      currentMenu: currentMenu ?? this.currentMenu,
      imageData: imageData ?? this.imageData,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
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
