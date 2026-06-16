import 'package:card_holder/common/application/app_settings.dart';
import 'package:flutter/material.dart';

/// App-specific text styles registered as a [ThemeExtension].
final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.displayMedium,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyMedium,
    required this.bodySmall,
    required this.displaySmall,
    required this.labelSmall,
  });

  final TextStyle displayMedium;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle displaySmall;
  final TextStyle labelSmall;

  static final _tekturBase = AppTextStyles(
    displayMedium: _tekturStyle(fontSize: 18, weight: FontWeight.bold),
    headlineLarge: _tekturStyle(fontSize: 32, weight: FontWeight.w500),
    headlineMedium: _tekturStyle(fontSize: 22, weight: FontWeight.w500),
    headlineSmall: _tekturStyle(fontSize: 18, weight: FontWeight.w500),
    titleLarge: _tekturStyle(fontSize: 20, weight: FontWeight.w400),
    titleMedium: _tekturStyle(fontSize: 18, weight: FontWeight.w400),
    titleSmall: _tekturStyle(fontSize: 16, weight: FontWeight.w400),
    bodyMedium: _tekturStyle(fontSize: 18, weight: FontWeight.w400),
    bodySmall: _tekturStyle(fontSize: 14, weight: FontWeight.w400),
    displaySmall: _tekturStyle(fontSize: 16, weight: FontWeight.w600),
    labelSmall: _tekturStyle(fontSize: 12, weight: FontWeight.w400),
  );

  static final light = AppTextStyles(
    displayMedium: _tekturBase.displayMedium.ls25.darkGrey,
    headlineLarge: _tekturBase.headlineLarge,
    headlineMedium: _tekturBase.headlineMedium.mainBlack,
    headlineSmall: _tekturBase.headlineSmall.mainBlack,
    titleLarge: _tekturBase.titleLarge,
    titleMedium: _tekturBase.titleMedium,
    titleSmall: _tekturBase.titleSmall,
    bodyMedium: _tekturBase.bodyMedium.darkGrey,
    bodySmall: _tekturBase.bodySmall.subGrey,
    displaySmall: _tekturBase.displaySmall.darkGrey,
    labelSmall: _tekturBase.labelSmall,
  );

  static final dark = AppTextStyles(
    displayMedium: _tekturBase.displayMedium.ls2,
    headlineLarge: _tekturBase.headlineLarge.mainWhite,
    headlineMedium: _tekturBase.headlineMedium.mainWhite,
    headlineSmall: _tekturBase.headlineSmall.mainWhite,
    titleLarge: _tekturBase.titleLarge.mainWhite,
    titleMedium: _tekturBase.titleMedium.mainWhite,
    titleSmall: _tekturBase.titleSmall.mainWhite,
    bodyMedium: _tekturBase.bodyMedium.darkGrey,
    bodySmall: _tekturBase.bodySmall.darkGrey,
    displaySmall: _tekturBase.displaySmall.darkGrey,
    labelSmall: _tekturBase.labelSmall.darkGrey,
  );

  static TextStyle _tekturStyle({
    required double fontSize,
    required FontWeight weight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Tektur',
      fontSize: fontSize,
      fontWeight: weight,
      color: color ?? AppColors.mainBlack,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  @override
  AppTextStyles copyWith({
    TextStyle? displayMedium,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? displaySmall,
    TextStyle? labelSmall,
  }) {
    return AppTextStyles(
      displayMedium: displayMedium ?? this.displayMedium,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      displaySmall: displaySmall ?? this.displaySmall,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}

extension TextStyleExtension on TextStyle {
  // ─── Colors ─────────────────────────────────────────────

  TextStyle get darkGrey => copyWith(color: AppColors.darkGrey);

  TextStyle get mainBlack => copyWith(color: AppColors.mainBlack);

  TextStyle get mainWhite => copyWith(color: AppColors.mainWhite);

  TextStyle get mainGray => copyWith(color: AppColors.mainGray);

  TextStyle get subGrey => copyWith(color: AppColors.subGrey);

  TextStyle get subBlack => copyWith(color: AppColors.subBlack);

  TextStyle get subBlack2 => copyWith(color: AppColors.subBlack2);

  TextStyle get mainGreen => copyWith(color: AppColors.mainGreen);

  TextStyle get mainRed => copyWith(color: AppColors.mainRed);

  TextStyle get white => copyWith(color: AppColors.mainWhite);

  TextStyle get alpha3 =>
      copyWith(color: AppColors.mainBlack.withValues(alpha: 0.3));

  TextStyle get grey500 => copyWith(color: AppColors.grey500);

  // ─── Heights ────────────────────────────────────────────

  TextStyle get h135 => copyWith(height: 1.35);

  TextStyle get h11 => copyWith(height: 1.1);

  TextStyle get h14 => copyWith(height: 1.1);

  TextStyle get h0 => copyWith(height: 0);

  // ─── Letter spacing ─────────────────────────────────────

  TextStyle get ls0 => copyWith(letterSpacing: 0);
  TextStyle get ls052 => copyWith(letterSpacing: 0.52);
  TextStyle get ls055 => copyWith(letterSpacing: 0.52);
  TextStyle get ls2 => copyWith(letterSpacing: 2);
  TextStyle get ls25 => copyWith(letterSpacing: 2.5);

  // ─── Font sizes ─────────────────────────────────────────

  TextStyle get fs10 => copyWith(fontSize: 10);
  TextStyle get fs8 => copyWith(fontSize: 8);

  // ─── Font weight ─────────────────────────────────────────
  TextStyle get fw600 => copyWith(fontWeight: FontWeight.w600);
}
