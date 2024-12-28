import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';


class CreateOrUpdateCarModelUseCase implements UsecaseWithParams<Unit, DataMap> {
  final CarModelRepository repository;

  CreateOrUpdateCarModelUseCase({required this.repository});

  @override
  ResultFuture<Unit> call(DataMap params) {
    return repository.createOrUpdateCarModel(params);
  }
}
