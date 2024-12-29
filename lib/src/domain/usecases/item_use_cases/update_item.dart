import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/core/usecase/usecase.dart';
import 'package:piece_autos/src/domain/entities/item.dart';

import '../../repositories/item_repo/item_repo.dart';

class UpdateItemUseCase implements UsecaseWithParams<void, DataMap> {
  final ItemRepository repository;

  UpdateItemUseCase({required this.repository});

  @override
  ResultFuture<void> call(DataMap params) {
    final String id = params['id']; 
    Item item = params['item'];// Extract ID from params
    return repository.updateItem(id, item);
  }
}
