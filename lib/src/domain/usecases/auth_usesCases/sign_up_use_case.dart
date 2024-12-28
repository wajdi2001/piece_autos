

import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/usecase/usecase.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/repositories/auth_repo/auth_repo.dart';

class SignUpUseCase implements UsecaseWithParams<Unit, DataMap> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  ResultFuture<Unit> call(DataMap params) {
    return repository.signUp(params);
  }
}
