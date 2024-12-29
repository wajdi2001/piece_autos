import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/car_model_repo/car_model_repo.dart';

class DeleteCarModelUseCase implements UsecaseWithParams<bool, String> {
  final CarModelRepository repository;

  DeleteCarModelUseCase({required this.repository});

  @override
  ResultFuture<bool> call(String id) {
    return repository.deleteCarModel(id);
  }
}
