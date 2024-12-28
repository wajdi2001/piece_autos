import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/utils/typedef.dart';

abstract class CarModelRepository {
  ResultFuture<DataMap> getAllCarModels(DataMap params); // For GET
  ResultFuture<Unit> createOrUpdateCarModel(DataMap params); // For POST
  ResultFuture<Unit> deleteCarModel(String id); // For DELETE
}
