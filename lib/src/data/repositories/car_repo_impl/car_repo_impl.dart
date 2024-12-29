import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/errors/failure.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/car_model_model.dart';

import '../../../domain/repositories/car_model_repo/car_model_repo.dart';
import '../../datasources/remote/car_model_remote_data_source/car_model_remote_data_source.dart';

class CarModelRepositoryImpl implements CarModelRepository {
  final CarModelRemoteDataSource remoteDataSource;

  CarModelRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<CarModelModel>> getAllCarModels(DataMap? params) async {
    try {
      // Fetch data from the remote data source
      final result = await remoteDataSource.getAllCarModels(params ?? {});

      // Parse the response if it contains "items"
      if (result.isNotEmpty && result.containsKey("items")) {
        final List<CarModelModel> resultList = result["items"]
            .map<CarModelModel>((item) => CarModelModel.fromJson(item))
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
  ResultFuture<String?> createOrUpdateCarModel(DataMap params) async {
    try {
      final res = await remoteDataSource.createOrUpdateCarModel(params);
      return Right(res["id"]);
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
