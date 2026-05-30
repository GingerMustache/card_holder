import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SpaceX on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

extension TextThemeExtensions on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
}

extension ColorExtension on Color {
  // ─── Alpha ──────────────────────────────────────────────

  Color get alpha02 => withValues(alpha: 0.2);
  Color get alpha03 => withValues(alpha: 0.3);
  Color get alpha05 => withValues(alpha: 0.5);
  Color get alpha08 => withValues(alpha: 0.8);
}

extension TextStyleExtension on TextStyle {
  // ─── Alpha ──────────────────────────────────────────────

  TextStyle get alpha02 => copyWith(color: color?.alpha02);
  TextStyle get alpha03 => copyWith(color: color?.alpha03);
  TextStyle get alpha05 => copyWith(color: color?.alpha05);
  TextStyle get alpha08 => copyWith(color: color?.alpha08);
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
  bool get notEmptyNotNull => this != null && this!.trim() != '';
}

extension EmailValidator on String {
  bool get isValidEmail =>
      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);
  bool get containsAlphabetic => RegExp(r'[a-zA-Z]').hasMatch(this);
  String get onlyNumbers => replaceAll(RegExp(r'[^\d]'), '');
}

extension OnTapExtension on Widget {
  Widget onTap(VoidCallback onTap) =>
      InkWell(splashFactory: null, onTap: onTap, child: this);
}

extension NumberFormatterExtension on String {
  String get formatWithSpaces {
    final onlyNumbers = replaceAll(RegExp(r'[^\d]'), '');
    if (onlyNumbers.isEmpty) return '';

    final formatter = NumberFormat('#,###', 'en');
    final formattedCode = formatter
        .format(int.tryParse(onlyNumbers) ?? 0)
        .replaceAll(',', ' ');
    return formattedCode;
  }
}
