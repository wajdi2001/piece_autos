import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/usecases/brand_use_cases/create_or_update_brand.dart';
import 'package:piece_autos/src/domain/usecases/car_model_use_cases/create_or_update.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

part 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static DashboardBloc get(context) => BlocProvider.of(context);
  DashboardBloc(
    this._globalBloc,
  ) : super(DashboardState()) {
    on<DashboadChnageMenuEvent>(onDashboardChangeMenu);
    on<DashboardSelectImageEvent>(onDashboardSelectImage);
    on<DashboardUpsertBrandEvent>(onDashboardUpsertBrand);
    on<DashboardChangeSelectedBrandEvent>(onDashboardChangeSelectedBrandEvent);
    on<DashboardUpsertCarModelEvent>(
      onDashboardUpsertCarModelEvent,
    );
  }

  FutureOr<void> onDashboardChangeSelectedBrandEvent(
      DashboardChangeSelectedBrandEvent event, emit) {
    emit(state.copyWith(selectedBrandId: event.brandId));
  }

  final GlobalBloc _globalBloc;

  FutureOr<void> onDashboardChangeMenu(DashboadChnageMenuEvent event, emit) {
    emit(state.copyWith(currentMenu: event.menu));
  }

  Future<void> onDashboardSelectImage(
      DashboardSelectImageEvent event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(
        imageData: ImageData(
      data: event.imageBytes,
      name: event.imageName,
      extension: event.imageExtension,
    )));
  }

  FutureOr<void> onDashboardUpsertBrand(
      DashboardUpsertBrandEvent event, emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final upsertBrandUserCase = sl<CreateOrUpdateBrandUseCase>();

    final DataMap request = {
      "name": event.name,
      "id": event.brandId,
      "image": state.imageData,
    };

    final result = await upsertBrandUserCase(request);
    result.fold((f) {
      emit(
          state.copyWith(status: StateStatus.failed, errorMsg: f.errorMessage));
    }, (r) {
      if (r != null) {
        _globalBloc.add(GlobalCreateOrUpdateBrandEvent(brandModel: r));
      }
    });
  }

  FutureOr<void> onDashboardUpsertCarModelEvent(
      DashboardUpsertCarModelEvent event, emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final createOrUpdateCarModelUseCase = sl<CreateOrUpdateCarModelUseCase>();
    final DataMap request = {
      "id": event.carModelId,
      "name": event.name,
      "brandId": state.selectedBrandId,
      "yearOfConstruction": event.yearOfConstruction,
    };

    final result = await createOrUpdateCarModelUseCase(request);
    result.fold((f) {
      emit(
          state.copyWith(status: StateStatus.failed, errorMsg: f.errorMessage));
    }, (r) {
      if (r != null) {
        _globalBloc.add(GlobalCreateOrUpdateCarModelEvent(carModel: r));
      }
    });
  }
}
