import 'dart:ui';

/// Public constants
final class Public {
  Public._();

  /// Build version. With each build, this number increases by one
  static const int build = 5;

  /// The date of this [build]
  static const String versionSignature = "4_4_2025";

  /// Determines if development mode things should be hidden or not
  static const bool isRelease = bool.fromEnvironment("RELEASE", defaultValue: false);
}

/// Colors extracted from the game
final class PublicTheme {
  /// #ee0a03
  static const Color dangerRed = Color(0xFFEE0A03);

  /// #fafcf9
  static const Color normalWhite = Color(0xFFFAFCF9);

  /// #020200
  static const Color abyssBlack = Color(0xFF020200);

  /// #ff7f15
  static const Color highlightOrange = Color(0xFFFF7F15);

  /// #ffbb02
  static const Color loreYellow = Color(0xFFFFBB02);

  /// #637c89
  static const Color hiddenGray = Color(0xFF637C89);

  /// #0b0f12
  static const Color murkyDarkGrey = Color(0xFF0B0F12);

  /// #21cc62
  static const Color fumingGreen = Color(0xFF21CC62);

  /// #f2e53b
  static const Color metricsYellow = Color(0xFFF2E53B);
}
