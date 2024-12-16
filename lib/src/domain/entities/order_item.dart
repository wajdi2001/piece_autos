import 'package:equatable/equatable.dart';

abstract class OrderItem extends Equatable{
  final String id;
  final String itemId;
  final int quantity;
  const OrderItem({required this.id, required this.itemId, required this.quantity});
  
  @override
  List<Object> get props => [id, itemId, quantity];
}