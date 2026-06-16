import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/application/app_text_styles.dart';
import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = lightThemeData;
  static final ThemeData darkTheme = darkThemeData;
}
