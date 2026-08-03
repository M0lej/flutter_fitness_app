import 'package:flutter/material.dart';

class AppTheme {
  // static const Color myRed = Color.fromARGB(255, 204, 38, 38);
  static const Color backgroundBlack = Color.fromARGB(255, 23, 21, 30);
  static const Color borderColor = Color.fromARGB(255, 52, 48, 62);
  static const Color red = Color.fromARGB(255, 237, 20, 5);

  ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    focusColor: const Color.fromARGB(255, 45, 42, 54),
    highlightColor: red,

    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.white70,
    ),

    scaffoldBackgroundColor: backgroundBlack,

    cardTheme: CardThemeData(
      margin: EdgeInsets.all(0),
      color: const Color.fromARGB(255, 31, 29, 37),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: borderColor),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 31, 29, 37),
      selectedIconTheme: IconThemeData(color: red),
      selectedItemColor: red,
    ),
    iconTheme: IconThemeData(color: const Color.fromARGB(255, 237, 20, 5)),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(red),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        iconColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: backgroundBlack,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 31, 29, 37),
      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
      hintStyle: TextStyle(color: Colors.white60, fontSize: 15),
      iconColor: Colors.white70,
      suffixIconColor: Colors.white70,
      prefixIconColor: Colors.white70,
      isDense: true,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: backgroundBlack,
      scrolledUnderElevation: 0,
    ),

    segmentedButtonTheme: SegmentedButtonThemeData(
      style: const ButtonStyle(
        backgroundColor: WidgetStateProperty.fromMap(
          <WidgetStatesConstraint, Color>{WidgetState.selected: AppTheme.red},
        ),
        foregroundColor: WidgetStateProperty.fromMap(
          <WidgetStatesConstraint, Color>{WidgetState.selected: Colors.white},
        ),
        side: WidgetStateBorderSide.fromMap(
          <WidgetStatesConstraint, BorderSide>{
            WidgetState.selected: BorderSide(width: 0),
          },
        ),
      ),
    ),
  );
}
