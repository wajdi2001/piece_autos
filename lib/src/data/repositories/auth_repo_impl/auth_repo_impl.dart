

import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/utils/typedef.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../domain/repositories/auth_repo/auth_repo.dart';
import '../../datasources/remote/auth_remote_data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

 @override
  ResultFuture<Unit> signUp(DataMap params) async {
  try {
    await remoteDataSource.signUp(params);
    return Right(unit); 
  } catch (e) {
    if (e is APIException) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } else {
      return Left(APIFailure(message: e.toString(), statusCode: 500)); // Default status code for unknown errors
    }
  }
}


  @override
  ResultFuture<Unit> signIn(DataMap params) async {
    try {
      await remoteDataSource.signIn(params);
      return Right(unit); 
    } catch (e) {
    if (e is APIException) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } else {
      return Left(APIFailure(message: e.toString(), statusCode: 500)); // Default status code for unknown errors
    }
  }
  }
}
