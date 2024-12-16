import 'package:equatable/equatable.dart';
import 'package:piece_autos/core/services/enums.dart';

 abstract class User extends Equatable{
  final String id;
  final String name;
  final String email;
  final String password;
  final UserType type;

   const  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
  });

      
        @override
        List<Object?> get props => [id, name, email, password, type];
        


  
}
