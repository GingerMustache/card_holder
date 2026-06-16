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
    surface: AppColors.mainWhite,
    primary: AppColors.mainGray,
    secondary: AppColors.lightSecondaryColor,
    onPrimary: AppColors.mainBlack,
    onSecondary: AppColors.mainWhite,
    secondaryContainer: Color.fromARGB(255, 255, 206, 191),
    surfaceTint: AppColors.darkGrey,
    outline: AppColors.steam,
    onSurface: AppColors.subGrey,
    error: AppColors.errorRed,
  ),
  extensions: [
    AppTextStyles.light,
  ],
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.mainBlack),
);
