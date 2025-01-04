import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/car_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';

class GetAllCarModelsUseCase
    implements UsecaseWithParams<List<DomainCarModel>, DataMap?> {
  final CarModelRepository repository;

  GetAllCarModelsUseCase({required this.repository});

  @override
  ResultFuture<List<DomainCarModel>> call(DataMap? data) {
    return repository.getAllCarModels(data);
  }
}
