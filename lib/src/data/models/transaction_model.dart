import 'package:piece_autos/src/domain/entities/transaction.dart';

class TransactionModel extends Transaction{
  const TransactionModel({
    required super.id, required super.userId, required super.transactionType
  });
  

  TransactionModel copyWith({
    String? id,
    String? userId,
    String? transactionType,
    
  }) {
    return TransactionModel(
      id: id?? this.id,
      userId: userId?? this.userId,
      transactionType: transactionType?? this.transactionType,
    
    );
  }
}