import 'dart:convert';

import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/brand.dart';

class BrandModel extends Brand {
  const BrandModel({
    required super.id,
    required super.name,
    super.image,
    required super.brandType,
  });

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    BrandType? brandType,
  }) {
    return BrandModel(
      id: id ?? super.id,
      name: name ?? super.name,
      image: image ?? super.image,
      brandType: brandType ?? this.brandType,
    );
  }

  factory BrandModel.fromJson(DataMap json) {
    return BrandModel(
        id: json['id'],
        name: json['name'],
        image: json['imageUrl'],
        brandType: BrandType.values[json['brandType']]);
  }
  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': image,
      'brandType': brandType.index,
    };
  }

  String toJson1() {
    return jsonEncode({
      'id': id,
      'name': name,
      'imageUrl': image,
      'brandType': brandType.index
    });
  }

  factory BrandModel.fromJson1(String jsonString) {
    final json = jsonDecode(jsonString);
    return BrandModel(
      id: json['id'],
      name: json['name'],
      image: json['imageUrl'],
      brandType: BrandType.values[json['brandType']],
    );
  }
}
