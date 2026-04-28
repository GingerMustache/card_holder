part of 'base_theme.dart';

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 39, 40, 40),
  useMaterial3: true,
  fontFamily: 'Tektur',
  iconTheme: const IconThemeData(color: AppColors.darkGrey),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(color: AppColors.darkGrey, fontSize: 18.0),
    backgroundColor: AppColors.black26,
    iconTheme: IconThemeData(color: AppColors.darkGrey),
  ),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 39, 40, 40),
    primary: AppColors.steam,
    secondary: AppColors.lightSecondaryColor,
    onPrimary: AppColors.mainBlack,
    onSecondary: AppColors.steam,
    // surfaceContainerHighest: AppColors.mainBlack,
    // surface: AppColors.mainWhite,
    secondaryContainer: Color.fromARGB(255, 255, 206, 191),
    surfaceTint: AppColors.darkGrey,
    outline: AppColors.mainWhite,
    onSurface: AppColors.subGrey,
    error: AppColors.errorRed,
  ),

  textTheme: TextTheme(
    displayMedium: _getTextStyleFromTheme(
      fontSize: 18.0,
      letterSpacing: 2,
      fontWeight: FontWeight.bold,
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
      color: AppColors.mainGray,
    ),
    bodyMedium: _getTextStyleFromTheme(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGrey,
    ),
    bodySmall: _getTextStyleFromTheme(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGrey,
    ),
    displaySmall: _getTextStyleFromTheme(
      fontSize: 16.0,
      color: AppColors.darkGrey,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: _getTextStyleFromTheme(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.mainBlack),
);
