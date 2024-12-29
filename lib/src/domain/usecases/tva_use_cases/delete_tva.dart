
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/repositories/tva_repo/tva_repo.dart';

import '../../../../core/usecase/usecase.dart';

class DeleteTVAUseCase extends UsecaseWithParams<bool, String> {
  final TVARepository repository;

  const DeleteTVAUseCase(this.repository);

  @override
  ResultFuture<bool> call(String params) async {
    return await repository.deleteTVA(params);
  }
}
