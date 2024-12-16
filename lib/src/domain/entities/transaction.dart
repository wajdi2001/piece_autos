import 'package:equatable/equatable.dart';

abstract class Transaction extends Equatable{
  final String id;
  final String userId;
  final String transactionType;

  const Transaction({
    required this.id,
    required this.userId,
    required this.transactionType,
  });
  
  @override
  List<Object> get props => [id, userId, transactionType];
}