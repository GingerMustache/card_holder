part of 'base_theme.dart';

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 67, 67, 67),
  useMaterial3: true,
  fontFamily: 'Tektur',
  iconTheme: const IconThemeData(color: AppColors.darkGrey),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(color: AppColors.darkGrey, fontSize: 18.0),
    backgroundColor: AppColors.darkGrey,
    iconTheme: IconThemeData(color: AppColors.darkGrey),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.subBlack2,
    secondary: AppColors.black26,
    onPrimary: AppColors.mainGreen,
    onSecondary: AppColors.mainRed,
    // onSurface: AppColors.darkGrey,
    surfaceContainerHighest: Color.fromARGB(255, 252, 210, 210),
    surface: Color.fromARGB(255, 88, 47, 47),
    // onSurface: Colors.white,
    secondaryContainer: Color.fromARGB(255, 36, 20, 20),
  ),

  textTheme: TextTheme(
    displayMedium: _getTextStyleFromTheme(
      fontSize: 20.0,
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
      fontSize: 16.0,
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
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.mainBlue),
);
