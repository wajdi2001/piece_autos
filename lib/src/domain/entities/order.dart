import 'package:equatable/equatable.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/domain/entities/order_item.dart';
import 'package:piece_autos/src/domain/entities/restored_item.dart';

abstract class Order extends Equatable {
  final String id;
  final String clientName;
  final String clientPhoneNumber;
  final String clientAddress;
  final List<OrderItem> items;
  final List<RestoredItem> restoredItem;
  final OrderStatus status;
  final DeliveryType deliveryType;
  final double totalPrice;

  const Order({
    required this.id,
    required this.clientName,
    required this.clientPhoneNumber,
    required this.clientAddress,
    required this.items,
    required this.restoredItem,
    required this.status,
    required this.deliveryType,
    required this.totalPrice,
  });
  @override
  List<Object> get props => [
    id,
    clientName,
    clientPhoneNumber,
    clientAddress,
    items,
    restoredItem,
    status,
    deliveryType,
    totalPrice,
  ];
}
