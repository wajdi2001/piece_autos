import 'package:equatable/equatable.dart';

abstract  class RestoredItem extends Equatable
{
  final String id;
  final String itemId;
  final int quantity;
  final String? description;
  const RestoredItem({required this.id, required this.itemId, required this.quantity,  this.description});
  
  @override
  List<Object> get props => [id, itemId, quantity, description!];
  // RestoredItem copyWith({ // 
}