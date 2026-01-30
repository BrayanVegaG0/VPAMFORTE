import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsFuture = SharedPreferences.getInstance();

  runApp(App(prefsFuture: prefsFuture));
}