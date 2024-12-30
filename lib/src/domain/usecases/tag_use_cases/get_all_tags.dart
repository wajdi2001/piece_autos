import 'package:piece_autos/core/utils/typedef.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/tag.dart';
import '../../repositories/tag_repo/tag_repo.dart';

class GetAllTagsUseCase implements UsecaseWithParams<List<Tag>, DataMap?> {
  final TagRepository repository;

  GetAllTagsUseCase({required this.repository});

  @override
  ResultFuture<List<Tag>> call(DataMap? params) {
    return repository.getAllTags(params);
  }
}
