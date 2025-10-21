import 'package:flutter/material.dart';

extension SpaceX on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

extension TextThemeExtensions on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
}

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get halfWidth => MediaQuery.of(this).size.width / 2;
  double get bottomPadding => MediaQuery.of(this).viewInsets.bottom;
}

extension PaddingExtension on Widget {
  Widget padAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget padSymmetric({double v = 0, double h = 0}) => Padding(
    padding: EdgeInsets.symmetric(vertical: v, horizontal: h),
    child: this,
  );
}

extension StringExtension on String? {
  String get notNull => this ?? '';
}

extension EmailValidator on String {
  bool get isValidEmail =>
      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);
}

extension OnTapExtension on Widget {
  Widget onTap(VoidCallback onTap) =>
      InkWell(splashFactory: null, onTap: onTap, child: this);
}
