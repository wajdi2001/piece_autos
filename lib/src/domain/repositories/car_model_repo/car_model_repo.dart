  import 'package:piece_autos/core/utils/typedef.dart';

  import '../../entities/car_model.dart';

  abstract class CarModelRepository {
    ResultFuture<List<CarModel>> getAllCarModels(DataMap? params); // For GET
    ResultFuture<String?> createOrUpdateCarModel(DataMap params); // For POST
    ResultFuture<bool> deleteCarModel(String id); // For DELETE
  }
