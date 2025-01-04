import 'dart:convert';

import 'package:piece_autos/core/utils/typedef.dart';

import '../../domain/entities/tag.dart';

class TagModel extends Tag {
  const TagModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    super.tagType,
  });

  TagModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    TagType? tagType,
  }) {
    return TagModel(
      id: id ?? super.id,
      name: name ?? super.name,
      imageUrl: imageUrl ?? super.imageUrl,
      tagType: tagType ?? this.tagType,
    );
  }

  //fromJson
  factory TagModel.fromJson(DataMap json) {
    return TagModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      tagType: TagType.values[json['tagType']],
    );
  }

  //toJson
  DataMap toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'imageUrl': super.imageUrl,
      'tagType': super.tagType.index,
    };
  }

  String toJson1() {
    return jsonEncode({
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'tagType': tagType.index,
    });
  }

  factory TagModel.fromJson1(String jsonString) {
    final json = jsonDecode(jsonString);
    return TagModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      tagType: TagType.values[json['tagType']],
    );
  }
}
