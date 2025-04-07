import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/app_entry.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/utils/configurator.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences kPrefs;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Avoid using asyncs here, so we just use then
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    kPrefs = preferences;
    // Configurator here will parse and effectively make sure missing keys are auto-generated with their default values
    Configurator.initialize();
    debugPrint("IS_RELEASE_MODE=${Public.isRelease}");
    debugPrint("Loaded Preferences Values:\n${kPrefs.getKeys()}");
    runApp(const MainApp());
  });
}
