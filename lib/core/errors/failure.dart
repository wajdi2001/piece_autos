import 'package:equatable/equatable.dart';
import 'package:piece_autos/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message, super.statusCode = 0});

  LocalFailure.fromException(LocalException exception)
      : this(message: exception.message, statusCode: 0);
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode = 500});

  ServerFailure.fromException(APIException exception)
      : this(message: exception.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.statusCode = 400});
}

class InvalidResponseFailure extends Failure {
  const InvalidResponseFailure(
      {super.message = "Invalid Response", super.statusCode = 500});
}
