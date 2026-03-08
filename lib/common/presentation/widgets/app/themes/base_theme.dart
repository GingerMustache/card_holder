import 'package:card_holder/common/application/app_settings.dart';
import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = lightThemeData;
  static final ThemeData darkTheme = darkThemeData;
}

TextStyle _getTextStyleFromTheme({
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  Color? color,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    height: height,
    color: color ?? AppColors.mainBlack,
  );
}
