import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/brand.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/brand_repo/brand_repo.dart';

class GetAllBrandsUseCase implements UsecaseWithoutParams<List<Brand>> {
  final BrandRepository repository;

  GetAllBrandsUseCase(this.repository);

  @override
  ResultFuture<List<Brand>> call() {
    return repository.getAllBrands();
  }
}
