import 'package:piece_autos/src/domain/entities/order_item.dart';

class OrderItemModel extends OrderItem{
  const OrderItemModel({
    required super.id, required super.itemId, required super.quantity
  });

  OrderItemModel copyWith({
    String? id,
    String? itemId,
    int? quantity,
    
  }) {
    return OrderItemModel(
      id: id ?? super.id,
      itemId: itemId ?? super.itemId,
      quantity: quantity ?? super.quantity,
    
    );
  }
}