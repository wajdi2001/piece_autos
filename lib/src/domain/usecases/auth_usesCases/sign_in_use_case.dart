

import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/usecase/usecase.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/repositories/auth_repo/auth_repo.dart';

class SignInUseCase implements UsecaseWithParams<DataMap, DataMap> {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  @override
  ResultFuture<DataMap> call(DataMap params) {
    return repository.signIn(params);
  }
}
