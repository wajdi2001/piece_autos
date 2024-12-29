import 'package:piece_autos/core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../entities/item.dart';
import '../../repositories/item_repo/item_repo.dart';

class GetAllItemsUseCase implements UsecaseWithParams<List<Item>,DataMap?> {
  final ItemRepository repository;

  GetAllItemsUseCase({required this.repository});

  @override
  ResultFuture<List<Item>> call(DataMap? params) {
    return repository.getAllItems(params);
  }
}
