import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/usecases/brand_use_cases/create_or_update_brand.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';

part 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static DashboardBloc get(context) => BlocProvider.of(context);
  DashboardBloc() : super(DashboardState()) {
    on<DashboadChnageMenuEvent>(onDashboardChangeMenu);
    on<DashboardSelectImageEvent>(onDashboardSelectImage);
    on<DashboardUpsertBrandEvent>(onDashboardUpsertBrand);
  }

  FutureOr<void> onDashboardChangeMenu(DashboadChnageMenuEvent event, emit) {
    emit(state.copyWith(currentMenu: event.menu));
  }

  FutureOr<void> onDashboardSelectImage(
      DashboardSelectImageEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedImage: event.imageBytes));
  }

  FutureOr<void> onDashboardUpsertBrand(
      DashboardUpsertBrandEvent event, emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final upsertBrandUserCase = sl<CreateOrUpdateBrandUseCase>();

    final DataMap request = {
      "Name": event.name,
      "id": event.brandId,
    };
    if (state.selectedImage != null) {
      request.addEntries({
        "image": MultipartFile.fromBytes(state.selectedImage!),
      }.entries);
    }

    final result = await upsertBrandUserCase(request);
    result.fold((f) {
      emit(
          state.copyWith(status: StateStatus.failed, errorMsg: f.errorMessage));
    }, (r) {
      if (event.brandId == null) {}
    });
  }
}
