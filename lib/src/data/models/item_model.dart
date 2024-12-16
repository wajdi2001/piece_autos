import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
      required super.name,
      required super.images,
      required super.brandId,
      required super.ref,
      required super.price,
      required super.hasDiscount,
      required super.status,
      required super.quantity,
      required super.tvaId
  });
  
  ItemModel copyWith({
    String? id,
    String? name,
    List<String>? images,
    String? brandId,
    String? ref,
    double? price,
    bool? hasDiscount,
    ItemStatus? status,
    int? quantity,
    String? tvaId
    
  }) {
    return ItemModel(
      id: id?? this.id,
      name: name?? this.name,
      images: images?? this.images,
      brandId: brandId?? this.brandId,
      ref: ref?? this.ref,
      price: price?? this.price,
      hasDiscount: hasDiscount?? this.hasDiscount,
      status: status?? this.status,
      quantity: quantity?? this.quantity,
      tvaId: tvaId?? this.tvaId,
    
    );
  }
}
