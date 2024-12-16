import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/data/models/order_item_model.dart';
import 'package:piece_autos/src/data/models/restored_item_model.dart';

import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
required super.id,
      required super.clientName,
      required super.clientPhoneNumber,
      required super.clientAddress,
      required super.items,
      required super.restoredItem,
      required super.status,
      required super.deliveryType,
      required super.totalPrice
  });
 
  OrderModel copyWith({
    String? id,
    String? clientName,
    String? clientPhoneNumber,
    String? clientAddress,
    List<OrderItemModel>? items,
    List<RestoredItemModel>? restoredItem,
    
    OrderStatus? status,
    DeliveryType? deliveryType,
    double? totalPrice,
    
  }) {
    return OrderModel(
      id: id?? this.id,
      clientName: clientName?? this.clientName,
      clientPhoneNumber: clientPhoneNumber?? this.clientPhoneNumber,
      clientAddress: clientAddress?? this.clientAddress,
      items: items?? this.items,
      restoredItem: restoredItem?? this.restoredItem,
      status: status?? this.status,
      deliveryType: deliveryType?? this.deliveryType,
      totalPrice: totalPrice?? this.totalPrice,
    
    );
  }
}
