import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/data_car_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';

class CreateOrUpdateCarModelUseCase
    implements UsecaseWithParams<DataCarModel?, DataMap> {
  final CarModelRepository repository;

  CreateOrUpdateCarModelUseCase({required this.repository});

  @override
  ResultFuture<DataCarModel?> call(DataMap params) {
    return repository.createOrUpdateCarModel(params);
  }
}
