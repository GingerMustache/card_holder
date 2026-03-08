part of 'base_theme.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.mainWhite,
  useMaterial3: true,
  fontFamily: 'Tektur',
  iconTheme: const IconThemeData(color: AppColors.mainBlack),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(color: AppColors.mainWhite, fontSize: 18.0),
    backgroundColor: AppColors.mainWhite,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.mainGray,
    secondary: AppColors.lightSecondaryColor,
    onPrimary: AppColors.mainBlack,
    onSecondary: AppColors.mainWhite,
    // onSurface: AppColors.mainBlack, // main text color
    surfaceContainerHighest: AppColors.mainBlack,
    surface: AppColors.mainWhite,
    // onSurface: Colors.black,
    secondaryContainer: Color.fromARGB(255, 255, 206, 191),
  ),
  textTheme: TextTheme(
    displayMedium: _getTextStyleFromTheme(
      fontSize: 20.0,
      letterSpacing: 2.5,
      color: AppColors.darkGrey,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: _getTextStyleFromTheme(
      fontSize: 32.0,

      fontWeight: FontWeight.w500,
    ),
    headlineMedium: _getTextStyleFromTheme(
      fontSize: 22.0,
      color: AppColors.mainBlack,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: _getTextStyleFromTheme(
      fontSize: 18.0,
      color: AppColors.mainBlack,
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
    ),
    bodyMedium: _getTextStyleFromTheme(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGrey,
    ),
    bodySmall: _getTextStyleFromTheme(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.subGrey,
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
