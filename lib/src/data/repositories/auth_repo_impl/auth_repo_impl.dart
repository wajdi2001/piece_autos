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
      return Right(unit); // Return success
    } on APIException catch (e) {
      return Left(
        APIFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      ); // Handle API-specific exceptions
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      ); // Handle unknown exceptions
    }
  }

  @override
  ResultFuture<DataMap> signIn(DataMap params) async {
    try {
      DataMap res = await remoteDataSource.signIn(params);
      return Right(res); // Return success
    } on APIException catch (e) {
      return Left(
        APIFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      ); // Handle API-specific exceptions
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      ); // Handle unknown exceptions
    }
  }
}
