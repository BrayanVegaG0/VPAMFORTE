class User {
  final String idUser;
  final String nombre;
  final String token;
  final List<String> roles;

  const User({
    required this.idUser,
    required this.nombre,
    required this.token,
    required this.roles,
  });
}
