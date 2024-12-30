import 'package:equatable/equatable.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/domain/entities/car_model.dart';

abstract class Item extends Equatable {
  final String id;
  final String name;
  final List<String> images;
  final String brandId;
  final String ref;
  final double price;
  final bool hasDiscount;
  final double? discountPercentage;
  final ItemStatus status;
  final int quantity;
  final int? availableIn;
  final String tvaId;
  final List<String>? adaptableCarModels;
  final Map<String, String>? description;
  final List<String>? tags;

  const Item({
    required this.id,
    required this.name,
    required this.images,
    required this.brandId,
    required this.ref,
    required this.price,
    required this.hasDiscount,
    this.discountPercentage,
    required this.status,
    required this.quantity,
    this.availableIn,
    required this.tvaId,
    this.adaptableCarModels,
    this.description,
    this.tags,
  });

  @override
  List<Object> get props => [
        id,
        name,
        images,
        brandId,
        ref,
        price,
        hasDiscount,
        discountPercentage ?? 0,
        status,
        quantity,
        availableIn ?? 0,
        tvaId,
        adaptableCarModels ?? [],
        description ?? {},
        tags ?? [],
      ];
}
