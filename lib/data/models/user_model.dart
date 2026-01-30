import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.idUser,
    required super.nombre,
    required super.token,
    required super.roles,
  });

  Map<String, dynamic> toJson() => {
    'iduser': idUser,
    'nombreuser': nombre,
    'token': token,
    'roles': roles,
  };
}
