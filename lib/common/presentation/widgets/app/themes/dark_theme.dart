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
    secondaryContainer: Color.fromARGB(255, 255, 206, 191),
    surfaceTint: AppColors.darkGrey,
    outline: AppColors.mainWhite,
    onSurface: AppColors.subGrey,
    error: AppColors.errorRed,
  ),
  extensions: [
    AppTextStyles.dark,
  ],
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.mainBlack),
);
