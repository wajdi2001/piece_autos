import 'package:piece_autos/core/usecase/usecase.dart';

import '../../../../core/utils/typedef.dart';
import '../../repositories/item_repo/item_repo.dart';

class DeleteItemUseCase implements UsecaseWithParams<void, String> {
  final ItemRepository repository;

  DeleteItemUseCase({required this.repository});

  @override
  ResultFuture<void> call(String params) {
    return repository.deleteItem(params);
  }
}
