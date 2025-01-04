import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final TagType tagType;

  const Tag({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.tagType = TagType.static,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, tagType];
}

enum TagType { static, menu }
