import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/brand.dart';

abstract class BrandRepository {
  ResultFuture<List<Brand>> getAllBrands(); // For GET
  ResultFuture<DataMap?> createOrUpdateBrand(DataMap params); // For POST
  ResultFuture<bool> deleteBrand(String id); // For DELETE
}
