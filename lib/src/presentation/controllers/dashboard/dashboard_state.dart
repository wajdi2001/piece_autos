import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final StateStatus status;
  final String currentMenu;
  final File? selectedImageFile; // Store the selected image as a File
  final Uint8List? selectedImageBytes;
  final String? errorMsg;

  const DashboardState(
      {this.currentMenu = "Brand",
      this.selectedImageFile,
      this.selectedImageBytes,
      this.status = StateStatus.initial,
      this.errorMsg});

  @override
  List<Object?> get props => [
        currentMenu,
        selectedImageFile,
        selectedImageBytes,
        status,
      ];

  DashboardState copyWith(
      {String? currentMenu,
      File? selectedImageFile,
      Uint8List? selectedImageBytes,
      StateStatus? status,
      String? errorMsg}) {
    return DashboardState(
      currentMenu: currentMenu ?? this.currentMenu,
      selectedImageFile: selectedImageFile ?? this.selectedImageFile,
      selectedImageBytes: selectedImageBytes ?? this.selectedImageBytes,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

enum StateStatus { initial, loading, failed, succes }
