import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/tva.dart';

class TvaModel extends TVA {
  const TvaModel({required super.id, required super.name, required super.rate});

  TvaModel copyWith({
    String? id,
    String? name,
    double? rate,
  }) {
    return TvaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rate: rate ?? this.rate,
    );
  }

//fromJson
  factory TvaModel.fromJson(Map<String, dynamic> json) {
    return TvaModel(
      id: json['id'],
      name: json['name'],
      rate: json['rate'],
    );
  }
  //toJSON
  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'rate': rate,
    };
  }
}
