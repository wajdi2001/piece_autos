
import 'package:piece_autos/core/typedef.dart';

abstract class UsecaseWithParams<Out, In> {
  const UsecaseWithParams();

  ResultFuture<Out> call(In params);
}

abstract class UsecaseWithoutParams<Out> {
  const UsecaseWithoutParams();

  ResultFuture<Out> call();
}
