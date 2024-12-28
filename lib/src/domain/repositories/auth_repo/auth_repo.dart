import 'package:piece_autos/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  ResultFuture<Unit> signUp(DataMap params); // For SignUp
  ResultFuture<Unit> signIn(DataMap params); // For SignIn
}
