import 'package:piece_autos/src/domain/entities/tva.dart';

class TvaModel extends TVA{
  const TvaModel({
    required super.id, required super.name, required super.percentage

  });
  
  
  TvaModel copyWith({
    String? id,
    String? name,
    double? percentage,
    
  }) {
    return TvaModel(
      id: id?? this.id,
      name: name?? this.name,
      percentage: percentage?? this.percentage,
    
    );
    
 
}}