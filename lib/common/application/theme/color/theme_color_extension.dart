part of 'theme_color.dart';

extension ThemeColorsX on BuildContext {
  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;
}
