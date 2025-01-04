import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/errors/failure.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/tva.dart';
import 'package:piece_autos/src/domain/repositories/tva_repo/tva_repo.dart';
import '../../datasources/remote/tva_remote_data_source/tva_remote_data_source.dart';
import '../../models/tva_model.dart';

class TVARepositoryImpl implements TVARepository {
  final TVARemoteDataSource remoteDataSource;

  TVARepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<TVA>> getAllTVAs() async {
    try {
      final result = await remoteDataSource.getAllTVAs({});
      final List<TVA> tvaList = [];
      if (result.isNotEmpty && result.containsKey('items')) {
        for (var item in result['items']) {
          tvaList.add(TvaModel.fromJson(
              item)); // Assuming `TvaModel` has a `fromJson` method.
        }
      }
      return Right(tvaList);
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<TvaModel?> createOrUpdateTVA(DataMap params) async {
    try {
      final result = await remoteDataSource.createOrUpdateTVA(params);
      return Right(TvaModel.fromJson(result));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> deleteTVA(String id) async {
    try {
      final result = await remoteDataSource.deleteTVA(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
