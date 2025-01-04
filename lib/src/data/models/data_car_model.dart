import 'dart:convert';

import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/car_model.dart';

class DataCarModel extends DomainCarModel {
  const DataCarModel({
    required super.id,
    required super.name,
    required super.brandId,
    required super.yearOfConstruction,
  });

  DataCarModel copyWith({
    String? id,
    String? name,
    String? brandId,
    int? yearOfConstruction,
  }) {
    return DataCarModel(
      id: id ?? super.id,
      name: name ?? super.name,
      brandId: brandId ?? super.brandId,
      yearOfConstruction: yearOfConstruction ?? super.yearOfConstruction,
    );
  }

  factory DataCarModel.fromJson(DataMap json) {
    return DataCarModel(
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

  String toJson1() {
    return jsonEncode({
      'id': id,
      'name': name,
      'brandId': brandId,
      'yearOfConstruction': yearOfConstruction,
    });
  }

  factory DataCarModel.fromJson1(String jsonString) {
    final json = jsonDecode(jsonString);
    return DataCarModel(
      id: json['id'],
      name: json['name'],
      brandId: json['brandId'],
      yearOfConstruction: json['yearOfConstruction'],
    );
  }
}
