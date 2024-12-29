import 'package:piece_autos/core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../entities/item.dart';
import '../../repositories/item_repo/item_repo.dart';

class GetItemByIdUseCase implements UsecaseWithParams<Item, String> {
  final ItemRepository repository;

  GetItemByIdUseCase({required this.repository});

  @override
  ResultFuture<Item> call(String params) {
    return repository.getItemById(params);
  }
}
