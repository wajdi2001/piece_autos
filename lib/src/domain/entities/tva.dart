import 'package:equatable/equatable.dart';

abstract class TVA  extends Equatable{
  final String id;
  final String name;
  final double percentage;
  const TVA({required this.id, required this.name, required this.percentage});
  
  @override
  List<Object> get props => [id, name, percentage];

}