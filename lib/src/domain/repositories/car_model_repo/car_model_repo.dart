import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/data_car_model.dart';

import '../../entities/car_model.dart';

abstract class CarModelRepository {
  ResultFuture<List<DomainCarModel>> getAllCarModels(
      DataMap? params); // For GET
  ResultFuture<DataCarModel?> createOrUpdateCarModel(
      DataMap params); // For POST
  ResultFuture<bool> deleteCarModel(String id); // For DELETE
}
