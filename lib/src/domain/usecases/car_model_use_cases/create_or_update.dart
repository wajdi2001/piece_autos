import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';


class CreateOrUpdateCarModelUseCase implements UsecaseWithParams<String?, DataMap> {
  final CarModelRepository repository;

  CreateOrUpdateCarModelUseCase({required this.repository});

  @override
  ResultFuture<String?> call(DataMap params) {
    return repository.createOrUpdateCarModel(params);
  }
}
