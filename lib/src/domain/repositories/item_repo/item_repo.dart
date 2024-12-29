import 'package:piece_autos/core/utils/typedef.dart';

import '../../entities/item.dart';

abstract class ItemRepository {
  ResultFuture<List<Item>> getAllItems(DataMap? params);
  ResultFuture<Item> getItemById(String id);
  ResultFuture<void> createItem(Item item);
  ResultFuture<void> updateItem(String id, Item item);
  ResultFuture<void> deleteItem(String id);
}
