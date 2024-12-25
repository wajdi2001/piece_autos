import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/car_model.dart';

class CarModelModel extends CarModel{
   const  CarModelModel({
      required super.id,
    required super.name,
    required super.brandId,
    required super.yearOfConstruction,
  });


  
  CarModelModel copyWith({
     String? id,
     String? name,
     String? brandId,
     String? yearOfConstruction,
    
  }) {
    return CarModelModel(
      id: id ?? super.id,
      name: name ?? super.name,
      brandId: brandId ?? super.brandId,
      yearOfConstruction: yearOfConstruction ?? super.yearOfConstruction,
    
    );
  }
  factory   CarModelModel.fromJson(DataMap json) {
    return CarModelModel(
      id: json['id'],
      name: json['name'],
      brandId: json['brandId'],
      yearOfConstruction: json['yearOfConstruction'],
    );
  }
  
  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'brandId': brandId,
      'yearOfConstruction': yearOfConstruction,
    };
  }
}