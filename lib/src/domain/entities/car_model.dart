import 'package:equatable/equatable.dart';

abstract class DomainCarModel extends Equatable {
  final String id;
  final String name;
  final int yearOfConstruction;
  final String brandId;

  const DomainCarModel({
    required this.id,
    required this.name,
    required this.yearOfConstruction,
    required this.brandId,
  });

  @override
  List<Object> get props => [id, name, yearOfConstruction, brandId];
}
