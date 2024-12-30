import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final StateStatus status;
  final String currentMenu;
  final Uint8List? selectedImage; // Store the selected image as a File
  final String? errorMsg;

  const DashboardState(
      {this.currentMenu = "Brand",
      this.selectedImage,
      this.status = StateStatus.initial,
      this.errorMsg});

  @override
  List<Object?> get props => [currentMenu, selectedImage, status];

  DashboardState copyWith(
      {String? currentMenu,
      Uint8List? selectedImage,
      StateStatus? status,
      String? errorMsg}) {
    return DashboardState(
      currentMenu: currentMenu ?? this.currentMenu,
      selectedImage: selectedImage ?? this.selectedImage,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

enum StateStatus { initial, loading, failed, succes }
