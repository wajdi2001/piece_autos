import 'package:piece_autos/core/utils/typedef.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/tag_repo/tag_repo.dart';

class CreateOrUpdateTagUseCase implements UsecaseWithParams<String?, DataMap> {
  final TagRepository repository;

  CreateOrUpdateTagUseCase({required this.repository});

  @override
  ResultFuture<String?> call(DataMap params) {
    return repository.createOrUpdateTag(params);
  }
}
