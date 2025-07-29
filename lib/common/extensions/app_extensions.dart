import 'package:flutter/material.dart';

extension SpaceX on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

extension TextThemeExtensions on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}
