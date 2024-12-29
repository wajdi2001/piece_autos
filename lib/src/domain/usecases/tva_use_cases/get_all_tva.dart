
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/tva.dart';
import 'package:piece_autos/src/domain/repositories/tva_repo/tva_repo.dart';

import '../../../../core/usecase/usecase.dart';

class GetAllTVAsUseCase extends UsecaseWithoutParams<List<TVA>> {
  final TVARepository repository;

  const GetAllTVAsUseCase(this.repository);

  @override
  ResultFuture<List<TVA>> call() async {
    return await repository.getAllTVAs();
  }
}
