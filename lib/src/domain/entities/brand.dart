import 'package:equatable/equatable.dart';

abstract class Brand extends Equatable {
  final String id;
  final String name;
  final String? image;
  final BrandType brandType;
  const Brand({
    required this.id,
    required this.name,
    this.image,
    this.brandType = BrandType.car,
  });

  @override
  List<Object?> get props => [id, name, image, brandType];
}

enum BrandType {
  car,
  other,
}
