part of 'theme_text_style.dart';

extension AppThemeX on BuildContext {
  ThemeTextStyles get textStyles =>
      Theme.of(this).extension<ThemeTextStyles>()!;
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
