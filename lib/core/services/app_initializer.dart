import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/services/app.dart';
import 'package:flutter_ui_components/core/services/app_providers.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final localStorage = LocalStorage(sharedPreferences);

  runApp(
    MultiProvider(
      providers: AppProviders.providers(localStorage),
      child: const App(),
    ),
  );
}
