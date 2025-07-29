import 'package:card_holder/common/application/app_settings.dart';
import 'package:flutter/material.dart';

Color getColor(Set<WidgetState> states) {
  const Set<WidgetState> interactiveStates = <WidgetState>{
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return const Color(0xFFff8166);
  }
  return Colors.red;
}

class AppTheme {
  AppTheme._();

  static const Color _lightIconlColor = Colors.black;
  static const Color _lightPrimaryColor = Color(0xFFff8166);
  static const Color _lightSecondaryColor = Color(0xFFc7513b);
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkIconColor = Colors.white;
  static const Color _darkPrimaryColor = Color.fromARGB(255, 75, 14, 0);
  static const Color _darkSecondaryColor = Color.fromARGB(255, 107, 16, 0);
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.mainWhite,
    useMaterial3: true,
    fontFamily: 'ChackraPetch',
    indicatorColor: AppColors.mainBlack,
    iconTheme: const IconThemeData(color: AppColors.mainBlack),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
      color: AppColors.mainWhite,
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: Colors.white,
      onSurface: AppColors.mainBlack, // main text color
      surfaceContainerHighest: AppColors.mainBlack,
      surface: Colors.white,
      // onSurface: Colors.black,
      secondaryContainer: Color.fromARGB(255, 255, 206, 191),
    ),
    // iconTheme: const IconThemeData(color: AppColors.fontLightColor),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     foregroundColor: Colors.white,
    //     backgroundColor: _lightPrimaryColor,
    //     minimumSize: const Size(150, 50),
    //     padding: const EdgeInsets.symmetric(horizontal: 16),
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //     ),
    //   ),
    // ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(foregroundColor: _lightSecondaryColor),
    // ),
    // dividerTheme: const DividerThemeData(color: Colors.black12),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: Colors.black,
    //   selectionColor: Color.fromARGB(255, 255, 147, 147),
    // ),
    // textTheme: const TextTheme(
    //   headline1: TextStyle(
    //       fontSize: 28.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   headline2: TextStyle(
    //       fontSize: 26.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   headline3: TextStyle(
    //       fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   headline4: TextStyle(
    //       fontSize: 22.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   headline5: TextStyle(
    //       fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   headline6: TextStyle(
    //       fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   bodyText1: TextStyle(
    //       fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    //   bodyText2: TextStyle(
    //       fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.mainBlack,
    useMaterial3: true,
    fontFamily: 'ChackraPetch',
    indicatorColor: AppColors.mainBlue,
    iconTheme: const IconThemeData(color: AppColors.mainWhite),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
      color: _darkPrimaryColor,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      onSecondary: Colors.white,
      onSurface: AppColors.darkGrey,
      surfaceContainerHighest: Color.fromARGB(255, 252, 210, 210),
      surface: Color.fromARGB(255, 88, 47, 47),
      // onSurface: Colors.white,
      secondaryContainer: Color.fromARGB(255, 36, 20, 20),
    ),
    // iconTheme: const IconThemeData(color: _darkIconColor),
    // textTheme: _lightTextTheme,
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: _darkSecondaryColor,
    //     minimumSize: const Size(150, 50),
    //     padding: const EdgeInsets.symmetric(horizontal: 16),
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //     ),
    //   ),
    // ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(foregroundColor: _darkSecondaryColor),
    // ),
    // dividerTheme: const DividerThemeData(color: Colors.black12),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: Colors.white,
    //   selectionColor: Color.fromARGB(255, 255, 147, 147),
    // ),
    // textTheme: const TextTheme(
    //   headline1: TextStyle(
    //       fontSize: 28.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   headline2: TextStyle(
    //       fontSize: 26.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   headline3: TextStyle(
    //       fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   headline4: TextStyle(
    //       fontSize: 22.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   headline5: TextStyle(
    //       fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   headline6: TextStyle(
    //       fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   bodyText1: TextStyle(
    //       fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
    //   bodyText2: TextStyle(
    //       fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    // ),
  );
}
