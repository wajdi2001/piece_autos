import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/core/usecase/usecase.dart';
import 'package:piece_autos/src/domain/entities/item.dart';
import '../../repositories/item_repo/item_repo.dart';

class CreateItemUseCase implements UsecaseWithParams<void, Item> {
  final ItemRepository repository;

  CreateItemUseCase({required this.repository});

  @override
  ResultFuture<void> call(Item params) {
    return repository.createItem(params);
  }
}
