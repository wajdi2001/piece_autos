import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/errors/failure.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/tag_model.dart';
import '../../../domain/repositories/tag_repo/tag_repo.dart';
import '../../datasources/remote/tag_remote_data_source/tag_remote_data_source.dart';


class TagRepositoryImpl implements TagRepository {
  final TagRemoteDataSource remoteDataSource;

  TagRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<TagModel>> getAllTags(DataMap? params) async {
    try {
      final result = await remoteDataSource.getAllTags(params ?? {});

      if (result.isNotEmpty && result.containsKey("items")) {
        final List<TagModel> tags = result["items"]
            .map<TagModel>((item) => TagModel(id: item["id"], name: item["name"],imageUrl: item["imageUrl"]))
            .toList();

        return Right(tags);
      }

      return Right([]);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<String?> createOrUpdateTag(DataMap params) async {
    try {
      final result = await remoteDataSource.createOrUpdateTag(params);
      return Right(result["id"]);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> deleteTag(String id) async {
    try {
      final result = await remoteDataSource.deleteTag(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
