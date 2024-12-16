
import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  const APIException({required this.message, required this.statusCode});
  
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
  
  
}
//give me class Exceptions local
class LocalException extends Equatable implements Exception {
  const LocalException({required this.message});
  
  final String message;

  @override
  List<Object?> get props => [message];
  
  
}
