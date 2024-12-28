import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/brand_repo/brand_repo.dart';

class DeleteBrandUseCase implements UsecaseWithParams<bool, String> {
  final BrandRepository repository;

  DeleteBrandUseCase({required this.repository});

  @override
  ResultFuture<bool> call(String id) {
    return repository.deleteBrand(id);
  }
}
