import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/brand_repo/brand_repo.dart';

class CreateOrUpdateBrandUseCase implements UsecaseWithParams<String?, DataMap> {
  final BrandRepository repository;

  CreateOrUpdateBrandUseCase({required this.repository});

  @override
  ResultFuture<String?> call(DataMap params) {
    return repository.createOrUpdateBrand(params);
  }
}
