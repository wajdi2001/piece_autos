import 'package:piece_autos/src/domain/entities/restored_item.dart';

class RestoredItemModel  extends RestoredItem{
  const RestoredItemModel({
required super.id, required super.itemId, required super.quantity
  });
  

  RestoredItemModel copyWith({
    String? id,
    String? itemId,
    int? quantity,
    
  }) {
    return RestoredItemModel(
      id: id?? this.id,
      itemId: itemId?? this.itemId,
      quantity: quantity?? this.quantity,
    
    );
  }
}