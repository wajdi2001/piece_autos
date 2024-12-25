  import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/errors/failure.dart';

  typedef ResultFuture<T> = Future<Either<Failure, T>>;

  typedef ResultVoid = ResultFuture<Unit>;

  typedef DataMap = Map<String, dynamic>;
