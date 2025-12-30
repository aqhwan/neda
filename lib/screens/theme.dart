import 'package:flutter/material.dart';

const defaultLatainLocaleCode = defaultLocaleCode;
const defaultLocaleCode = 'en';

const defaultThemeType = ThemeType.light;

class NedaTheme {
  late final Color primary;
  late final Color surface;
  late final Color surfaceContainerHigh;
  late final Color font;
  late final Color error;

  static const double mainBorderRadiusSize = 60;

  static const String fontFamily = 'MainArabic';

  ThemeType type;

  factory NedaTheme({ThemeType type = defaultThemeType}) {
    return type == ThemeType.dark ? NedaTheme.dark() : NedaTheme.light();
  }

  factory NedaTheme.dark() {
    return NedaTheme._(
      type: ThemeType.dark,
      primary: const Color(0xffcfffb7),
      surface: const Color(0xff101010),
      surfaceContainerHigh: const Color(0xff262626),
      font: const Color(0xffffffff),
      error: const Color(0xffffffff),
    );
  } // no light theme yet

  factory NedaTheme.light() => NedaTheme.light();

  NedaTheme._({
    required this.primary,
    required this.surface,
    required this.surfaceContainerHigh,
    required this.font,
    required this.type,
    required this.error,
  });

  ThemeData get data {
    final colorScheme = ColorScheme(
      primary: primary,
      secondary: primary,
      surface: surface,
      surfaceContainerHigh: surfaceContainerHigh,

      // Complementary colors (onX colors are for text/icons on those surfaces)
      onPrimary: font,
      onSecondary: font,
      onSurface: font,

      // Error colors (you can customize these too)
      error: error,
      onError: font,

      // Extra colors for your custom needs
      onTertiary: font,

      // Brightness
      brightness: type == ThemeType.light ? Brightness.light : Brightness.dark,
    );

    return ThemeData(
      // Use Material 3 (recommended)
      useMaterial3: true,

      // The main color scheme
      colorScheme: colorScheme,

      fontFamily: fontFamily,

      // Apply the colors to specific components
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: colorScheme.onSurface,
      ),

      // Card theme
      cardTheme: .new(color: surface),

      listTileTheme: .new(
        tileColor: surface,
        titleTextStyle: .new(color: primary, fontFamily: fontFamily),
        contentPadding: .only(right: 20, left: 20),
      ),

      // Dialog theme
      dialogTheme: .new(
        backgroundColor: surface,
        titleTextStyle: TextStyle(color: font, fontFamily: fontFamily),
        contentTextStyle: TextStyle(color: font, fontFamily: fontFamily),
      ),

      // Bottom sheet theme
      bottomSheetTheme: .new(
        backgroundColor: surface,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(NedaTheme.mainBorderRadiusSize),
            topRight: Radius.circular(NedaTheme.mainBorderRadiusSize),
            bottomLeft: Radius.circular(NedaTheme.mainBorderRadiusSize),
            bottomRight: Radius.circular(NedaTheme.mainBorderRadiusSize),
          ),
        ),
      ),

      // Floating action button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: colorScheme.onPrimary,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),

      // Text theme (optional - customize fonts)
      textTheme: .new(
        // Your text styles here
      ),
    );
  }

  // Helper method to get current theme based on context
  static NedaTheme of(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? NedaTheme.dark() : NedaTheme.light();
  }
}

class FontSize {
  static const double huge = 64.0;
  static const double large = 48.0;
  static const double medium = 34.0;
  static const double small = 16.0;
  static const double tiny = 10.0;
}

enum ThemeType { light, dark }
