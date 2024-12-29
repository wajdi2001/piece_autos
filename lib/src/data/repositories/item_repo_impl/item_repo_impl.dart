import 'package:dartz/dartz.dart';
import 'package:piece_autos/src/domain/entities/item.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../domain/repositories/item_repo/item_repo.dart';
import '../../datasources/remote/item_remote_data_source/item_remote_data_source.dart';
import '../../models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<ItemModel>> getAllItems(DataMap? params) async {
    try {
      // Fetch data from the remote data source
      final result = await remoteDataSource.getAllItems(params ?? {});

      // Parse the response if it contains "items"
      if (result.isNotEmpty && result.containsKey("items")) {
        final List<ItemModel> resultList = result["items"]
            .map<ItemModel>((item) => ItemModel.fromJson(item))
            .toList();

        return Right(resultList);
      }

      // Return an empty list if "items" key is missing
      return Right([]);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e)); // Handle API-specific errors
    } catch (e) {
      return Left(ServerFailure(message: e.toString())); // Handle general errors
    }
  }


  @override
  ResultFuture<bool> deleteItem(String id) async {
    try {
      final res = await remoteDataSource.deleteItem(id);
      return Right(res);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> createItem(Item item) {
    // TODO: implement createItem
    throw UnimplementedError();
  }

  @override
  ResultFuture<Item> getItemById(String id) {
    // TODO: implement getItemById
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> updateItem(String id, Item item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}
