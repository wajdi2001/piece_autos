import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.password,
      required super.type});

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    UserType? type,
  }) {
    return UserModel(
      id: id ?? super.id,
      name: name ?? super.name,
      email: email ?? super.email,
      password: password ?? super.password,
      type: type ?? super.type,
    );
  }
}
