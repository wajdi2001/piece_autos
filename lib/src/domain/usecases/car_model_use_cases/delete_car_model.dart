import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';

class DeleteCarModelUseCase implements UsecaseWithParams<Unit, String> {
  final CarModelRepository repository;

  DeleteCarModelUseCase({required this.repository});

  @override
  ResultFuture<Unit> call(String id) {
    return repository.deleteCarModel(id);
  }
}
