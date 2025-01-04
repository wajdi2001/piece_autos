import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/errors/failure.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/data_car_model.dart';

import '../../../domain/repositories/car_model_repo/car_model_repo.dart';
import '../../datasources/remote/car_model_remote_data_source/car_model_remote_data_source.dart';

class CarModelRepositoryImpl implements CarModelRepository {
  final CarModelRemoteDataSource remoteDataSource;

  CarModelRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<DataCarModel>> getAllCarModels(DataMap? params) async {
    try {
      // Fetch data from the remote data source
      final result = await remoteDataSource.getAllCarModels(params ?? {});

      // Parse the response if it contains "items"
      if (result.isNotEmpty && result.containsKey("items")) {
        final List<DataCarModel> resultList = result["items"]
            .map<DataCarModel>((item) => DataCarModel.fromJson(item))
            .toList();

        return Right(resultList);
      }

      // Return an empty list if "items" key is missing
      return Right([]);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e)); // Handle API-specific errors
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString())); // Handle general errors
    }
  }

  @override
  ResultFuture<DataCarModel?> createOrUpdateCarModel(DataMap params) async {
    try {
      final res = await remoteDataSource.createOrUpdateCarModel(params);
      if (res.isNotEmpty) {
        return Right(DataCarModel.fromJson(res));
      }
      return Left(InvalidResponseFailure());
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> deleteCarModel(String id) async {
    try {
      final res = await remoteDataSource.deleteCarModel(id);
      return Right(res);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
