import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/brand_repo/brand_repo.dart';

class CreateOrUpdateBrandUseCase
    implements UsecaseWithParams<BrandModel?, DataMap> {
  final BrandRepository repository;

  CreateOrUpdateBrandUseCase({required this.repository});

  @override
  ResultFuture<BrandModel?> call(DataMap params) {
    return repository.createOrUpdateBrand(params);
  }
}
