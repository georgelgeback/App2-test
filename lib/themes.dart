import 'package:flutter/material.dart';

final ThemeData fsekTheme = ThemeData(
  primaryColor: Colors.orange,
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black // Used on top of background or surface colors
    ),
    labelMedium: TextStyle(
      color: Colors.black // Used on top of the tertiary color
    ),
    titleMedium: TextStyle(
        color: Colors.black // Used on top of background or surface colors
    ),
    titleLarge: TextStyle(
      color: Colors.white // Must work on top of colorScheme.primary
    ),
    headlineSmall: TextStyle(
        color: Colors.black // Must work on top of surface
    ),
    titleSmall: TextStyle(
        color: Colors.black // Must work on top of colorScheme.tertiary
    )
  ),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(brightness: Brightness.light, primary: Colors.orange[800], secondary: Colors.orange[600],
      tertiary: Colors.grey[200], onTertiary: Colors.orange[600],
      background: const Color(0xFFF1F1F1), surface: Colors.white,
      onBackground: Colors.orange[600], onPrimary: Colors.grey[800],
      tertiaryContainer: Colors.grey[350], surfaceTint: Colors.orange[200],
      inverseSurface: Colors.black, error: Colors.red[600],
      onError: Colors.white, onSecondary: Colors.white),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.orange[700]),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> fsekBackground = [
  Color(0xFFf77e14),
  Color(0xFFe6660b),
];

final ThemeData fsekThemeDark = ThemeData(
  primaryColor: Colors.orange,
  textTheme: TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white // Used on top of background or surface colors
      ),
      labelMedium: TextStyle(
          color: Colors.white // Used on top of the tertiary color
      ),
      titleMedium: TextStyle(
          color: Colors.white // Used on top of background or surface colors
      ),
      titleLarge: TextStyle(
          color: Colors.white // Must work on top of colorScheme.primary
      ),
      headlineSmall: TextStyle(
          color: Colors.white // Must work on top of surface
      ),
      titleSmall: TextStyle(
          color: Colors.white // Must work on top of colorScheme.tertiary
      )
  ),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(brightness: Brightness.dark, primary: Colors.orange[800], secondary: Colors.orange[700],
      tertiary: Colors.grey[850], onTertiary: Colors.orange[600],
      background: const Color(0xFF121212), surface: Colors.grey[900],
      onBackground: Colors.orange[700], onPrimary: Colors.grey[800],
      tertiaryContainer: Colors.grey[800], surfaceTint: Colors.orange[600],
      inverseSurface: Colors.white, error: Colors.red[800],
      onError: Colors.white, onSecondary: Colors.white),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.orange[700]),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> fsekBackgroundDark = [
  Color(0xFFf77e14),
  Color(0xFFe6660b),
];

/*
final ThemeData nollning2023themeV0 = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF202C57),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(primary: Color(0xFF202C57), secondary: Color(0xFF202C57)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF202C57)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF202C57)),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> nollning2023BackgroundV0 = [
  Color(0xFF202C57),
  Color(0xFF202C57),
];

final ThemeData nollning2023themeV1 = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF4B6357),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(primary: Color(0xFF4B6357), secondary: Color(0xFF4B6357)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4B6357)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF4B6357)),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> nollning2023BackgroundV1 = [
  Color(0xFF4B6357),
  Color(0xFF4B6357),
];
//Här ska rätt färg in
final ThemeData nollning2023themeV2 = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF9B4C52),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(primary: Color(0xFF9B4C52), secondary: Color(0xFF9B4C52)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF9B4C52)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF9B4C52)),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> nollning2023BackgroundV2 = [
  Color(0xFF9B4C52),
  Color(0xFF9B4C52),
];
//Här ska rätt färg in
final ThemeData nollning2023themeV3 = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF260F3F),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(primary: Color(0xFF260F3F), secondary: Color(0xFF260F3F)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF260F3F)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF260F3F)),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> nollning2023BackgroundV3 = [
  Color(0xFF260F3F),
  Color(0xFF260F3F),
];

final ThemeData nollning2023themeV4 = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF165C7F),
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(primary: Color(0xFF165C7F), secondary: Color(0xFF165C7F)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF165C7F)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF165C7F)),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    labelStyle: TextStyle(color: Colors.orange),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);

final List<Color> nollning2023BackgroundV4 = [
  Color(0xFF165C7F),
  Color(0xFF165C7F),
];
*/