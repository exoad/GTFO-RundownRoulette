import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';

class Configurator {
  static Future<void> initialize() async {
    kPrefs.setBoolIfAbsent("color_lobby", true);
    kPrefs.setBoolIfAbsent("randomization_animation", true);
    kPrefs.setBoolIfAbsent("be_descriptive", true);
    kPrefs.setBoolIfAbsent("fuck_ads", false);
  }
}
