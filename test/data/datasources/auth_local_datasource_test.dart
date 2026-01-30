import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ficha_vulnerabilidad/data/datasources/local/auth_local_datasource.dart';
import 'package:ficha_vulnerabilidad/data/models/user_model.dart';

void main() {
  test('saveSession/getSession/clearSession funcionan correctamente', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final local = AuthLocalDataSourcePrefs(prefs: prefs);

    const user = UserModel(
      idUser: '242814',
      nombre: 'KEVIN IVAN',
      token: 'abc123',
      roles: ['VULNERABILIDAD'],
    );

    await local.saveSession(user);

    final loaded = await local.getSession();
    expect(loaded, isNotNull);
    expect(loaded!.idUser, '242814');
    expect(loaded.nombre, 'KEVIN IVAN');
    expect(loaded.token, 'abc123');
    expect(loaded.roles, ['VULNERABILIDAD']);

    final token = await local.getToken();
    expect(token, 'abc123');

    await local.clearSession();

    final cleared = await local.getSession();
    expect(cleared, isNull);
  });
}
