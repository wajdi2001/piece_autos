
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/repositories/tva_repo/tva_repo.dart';

import '../../../../core/usecase/usecase.dart';

class CreateOrUpdateTVAUseCase extends UsecaseWithParams<String?, DataMap> {
  final TVARepository repository;

  const CreateOrUpdateTVAUseCase(this.repository);

  @override
  ResultFuture<String?> call(DataMap params) async {
    return await repository.createOrUpdateTVA(params);
  }
}
