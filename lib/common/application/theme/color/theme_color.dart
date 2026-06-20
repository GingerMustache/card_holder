import 'package:card_holder/common/application/app_settings.dart';
import 'package:flutter/material.dart';

part 'theme_color_extension.dart';

/// App-specific colors registered as a [ThemeExtension].
final class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.scaffoldBackground,
    required this.icon,
    required this.appBarBackground,
    required this.appBarTitle,
    required this.appBarIcon,
    required this.tabBarIndicator,
    required this.surface,
    required this.primary,
    required this.secondary,
    required this.onPrimary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.surfaceTint,
    required this.outline,
    required this.onSurface,
    required this.error,
  });

  final Color scaffoldBackground;
  final Color icon;
  final Color appBarBackground;
  final Color appBarTitle;
  final Color appBarIcon;
  final Color tabBarIndicator;
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color onPrimary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color surfaceTint;
  final Color outline;
  final Color onSurface;
  final Color error;

  static const _darkSurface = Color.fromARGB(255, 39, 40, 40);
  static const _secondaryContainer = Color.fromARGB(255, 255, 206, 191);

  static const light = ThemeColors(
    scaffoldBackground: AppColors.mainWhite,
    icon: AppColors.mainBlack,
    appBarBackground: AppColors.mainWhite,
    appBarTitle: AppColors.mainWhite,
    appBarIcon: AppColors.mainBlack,
    tabBarIndicator: AppColors.mainBlack,
    surface: AppColors.mainWhite,
    primary: AppColors.mainGray,
    secondary: AppColors.lightSecondaryColor,
    onPrimary: AppColors.mainBlack,
    onSecondary: AppColors.mainWhite,
    secondaryContainer: _secondaryContainer,
    surfaceTint: AppColors.darkGrey,
    outline: AppColors.steam,
    onSurface: AppColors.subGrey,
    error: AppColors.errorRed,
  );

  static const dark = ThemeColors(
    scaffoldBackground: _darkSurface,
    icon: AppColors.darkGrey,
    appBarBackground: AppColors.black26,
    appBarTitle: AppColors.darkGrey,
    appBarIcon: AppColors.darkGrey,
    tabBarIndicator: AppColors.mainBlack,
    surface: _darkSurface,
    primary: AppColors.steam,
    secondary: AppColors.lightSecondaryColor,
    onPrimary: AppColors.mainBlack,
    onSecondary: AppColors.steam,
    secondaryContainer: _secondaryContainer,
    surfaceTint: AppColors.darkGrey,
    outline: AppColors.mainWhite,
    onSurface: AppColors.subGrey,
    error: AppColors.errorRed,
  );

  @override
  ThemeColors copyWith({
    Color? scaffoldBackground,
    Color? icon,
    Color? appBarBackground,
    Color? appBarTitle,
    Color? appBarIcon,
    Color? tabBarIndicator,
    Color? surface,
    Color? primary,
    Color? secondary,
    Color? onPrimary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? surfaceTint,
    Color? outline,
    Color? onSurface,
    Color? error,
  }) {
    return ThemeColors(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      icon: icon ?? this.icon,
      appBarBackground: appBarBackground ?? this.appBarBackground,
      appBarTitle: appBarTitle ?? this.appBarTitle,
      appBarIcon: appBarIcon ?? this.appBarIcon,
      tabBarIndicator: tabBarIndicator ?? this.tabBarIndicator,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      outline: outline ?? this.outline,
      onSurface: onSurface ?? this.onSurface,
      error: error ?? this.error,
    );
  }

  @override
  ThemeColors lerp(ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) return this;
    return ThemeColors(
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      appBarBackground: Color.lerp(appBarBackground, other.appBarBackground, t)!,
      appBarTitle: Color.lerp(appBarTitle, other.appBarTitle, t)!,
      appBarIcon: Color.lerp(appBarIcon, other.appBarIcon, t)!,
      tabBarIndicator:
          Color.lerp(tabBarIndicator, other.tabBarIndicator, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
