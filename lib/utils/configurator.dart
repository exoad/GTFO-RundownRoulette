import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';

class Configurator {
  static Future<void> initialize() async {
    kPrefs.setBoolIfAbsent("color_lobby", true);
  }
}
