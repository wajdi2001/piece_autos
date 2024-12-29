import 'package:piece_autos/core/utils/typedef.dart';
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

    
 
}

//fromJson
  factory TvaModel.fromJson(Map<String, dynamic> json) {
    return TvaModel(
      id: json['id'],
      name: json['name'],
      percentage: json['percentage'],
    );
  }
  //toJSON
  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
    };
  }
}