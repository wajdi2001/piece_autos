import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  final String id;
  final String name;
  final String imageUrl;

  const Tag({required this.id, required this.name, required this.imageUrl});
  
  @override
  
  List<Object?> get props => [id, name, imageUrl];
}
