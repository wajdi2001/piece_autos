import 'package:equatable/equatable.dart';

abstract class CarModel extends Equatable
{
  final String id;
  final String name;
  final String yearOfConstruction;
  final String brandId;

  const CarModel({
    required this.id,
    required this.name,
    required this.yearOfConstruction,
    required this.brandId,
  });
  
  @override
  List<Object> get props => [id, name, yearOfConstruction, brandId];
}