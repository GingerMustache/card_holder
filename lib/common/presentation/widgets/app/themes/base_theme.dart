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
    brightness: Brightness.light,
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
      primary: AppColors.mainGray,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: Colors.white,
      // onSurface: AppColors.mainBlack, // main text color
      surfaceContainerHighest: AppColors.mainBlack,
      surface: Colors.white,
      // onSurface: Colors.black,
      secondaryContainer: Color.fromARGB(255, 255, 206, 191),
    ),
    textTheme: TextTheme(
      headlineLarge: _getTextStyleFromTheme(
        fontSize: 32.0,

        fontWeight: FontWeight.w500,
      ),
      headlineMedium: _getTextStyleFromTheme(
        fontSize: 22.0,
        color: AppColors.mainBlack,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: _getTextStyleFromTheme(
        fontSize: 18.0,
        color: AppColors.mainBlack,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: _getTextStyleFromTheme(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: _getTextStyleFromTheme(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: _getTextStyleFromTheme(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: _getTextStyleFromTheme(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrey,
      ),
      bodySmall: _getTextStyleFromTheme(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: AppColors.subGrey,
      ),
    ),
  );
  static TextStyle _getTextStyleFromTheme({
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      color: color ?? AppColors.mainBlack,
    );
  }

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
      primary: AppColors.suBlack,
      secondary: _darkSecondaryColor,
      onPrimary: Colors.green,
      onSecondary: Colors.red,
      // onSurface: AppColors.darkGrey,
      surfaceContainerHighest: Color.fromARGB(255, 252, 210, 210),
      surface: Color.fromARGB(255, 88, 47, 47),
      // onSurface: Colors.white,
      secondaryContainer: Color.fromARGB(255, 36, 20, 20),
    ),

    textTheme: TextTheme(
      headlineLarge: _getTextStyleFromTheme(
        fontSize: 32.0,
        color: AppColors.darkGrey,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: _getTextStyleFromTheme(
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: _getTextStyleFromTheme(
        fontSize: 18.0,

        fontWeight: FontWeight.w500,
      ),
      titleLarge: _getTextStyleFromTheme(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: _getTextStyleFromTheme(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: _getTextStyleFromTheme(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: AppColors.mainWhite,
      ),
      bodyMedium: _getTextStyleFromTheme(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrey,
      ),
      bodySmall: _getTextStyleFromTheme(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrey,
      ),
    ),
  );
}
