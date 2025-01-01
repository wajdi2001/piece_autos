import 'dart:convert';

import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/brand.dart';

class BrandModel extends Brand {
  const BrandModel(
      {required super.id, required super.name, required super.image});

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return BrandModel(
      id: id ?? super.id,
      name: name ?? super.name,
      image: image ?? super.image,
    );
  }
  factory   BrandModel.fromJson(DataMap json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      image: json['imageUrl'],
    );
  }
  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': image,
    };
  }

    String toJson1() {
    return jsonEncode({
      'id': id,
      'name': name,
      'imageUrl': image,
    });
  }

  factory BrandModel.fromJson1(String jsonString) {
    final json = jsonDecode(jsonString);
    return BrandModel(
      id: json['id'],
      name: json['name'],
      image: json['imageUrl'],
    );
  }
}
