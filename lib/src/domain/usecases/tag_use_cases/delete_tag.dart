import 'package:piece_autos/core/utils/typedef.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/tag_repo/tag_repo.dart';

class DeleteTagUseCase implements UsecaseWithParams<bool, String> {
  final TagRepository repository;

  DeleteTagUseCase({required this.repository});

  @override
  ResultFuture<bool> call(String id) {
    return repository.deleteTag(id);
  }
}
