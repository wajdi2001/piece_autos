import 'dart:convert';

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
    super.discountPercentage,
    required super.status,
    required super.quantity,
    super.availableIn,
    required super.tvaId,
    super.adaptableCarModels,
    super.description,
    super.tags,
  });

  /// Factory method to create an `ItemModel` from JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      images: List<String>.from(json['imagesUrl'] ?? []),
      brandId: json['brandId'],
      ref: json['ref'],
      price: json['price'].toDouble(),
      hasDiscount: json['hasDiscount'],
      discountPercentage: json['discountPercentage']?.toDouble(),
      status: ItemStatus.values[json['itemStatus']],
      quantity: json['quantity'] ?? 0,
      availableIn: json['availableIn'],
      tvaId: json['tvaRate'].toString(),
      adaptableCarModels: List<String>.from(json['adaptableWith'] ?? []),
      description: (json['description'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value.toString())),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  /// Convert `ItemModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagesUrl': images,
      'brandId': brandId,
      'ref': ref,
      'price': price,
      'hasDiscount': hasDiscount,
      'discountPercentage': discountPercentage,
      'itemStatus': status.index,
      'quantity': quantity,
      'availableIn': availableIn,
      'tvaRate': tvaId,
      'adaptableWith': adaptableCarModels,
      'description': description,
      'tags': tags,
    };
  }

  // Convert an ItemModel to JSON
  String toJson1() {
    return jsonEncode({
      'id': id,
      'name': name,
      'imagesUrl': images,
      'brandId': brandId,
      'ref': ref,
      'price': price,
      'hasDiscount': hasDiscount,
      'discountPercentage': discountPercentage,
      'itemStatus': status.index,
      'quantity': quantity,
      'availableIn': availableIn,
      'tvaRate': tvaId,
      'adaptableWith': adaptableCarModels,
      'description': description,
      'tags': tags,
    });
  }

  factory ItemModel.fromJson1(String jsonString) {
    final json = jsonDecode(jsonString);
    return ItemModel(
      id: json['id'],
      name: json['name'],
      images: List<String>.from(json['imagesUrl'] ?? []),
      brandId: json['brandId'],
      ref: json['ref'],
      price: json['price'].toDouble(),
      hasDiscount: json['hasDiscount'],
      discountPercentage: json['discountPercentage']?.toDouble(),
      status: ItemStatus.values[json['itemStatus']],
      quantity: json['quantity'] ?? 0,
      availableIn: json['availableIn'],
      tvaId: json['tvaRate'].toString(),
      adaptableCarModels: List<String>.from(json['adaptableWith'] ?? []),
      description: (json['description'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value.toString())),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
