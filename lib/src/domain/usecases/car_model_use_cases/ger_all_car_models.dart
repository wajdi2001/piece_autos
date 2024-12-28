
import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';

class GetAllCarModelsUseCase implements UsecaseWithParams<DataMap, DataMap> {
  final CarModelRepository repository;

  GetAllCarModelsUseCase({required this.repository});

  @override
  ResultFuture<DataMap> call(DataMap params) {
    return repository.getAllCarModels(params);
  }
}
