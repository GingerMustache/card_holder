part of "app_settings.dart";

class AppColors {
  static const Color mainWhite = Color(0xFFFFFFFF);
  static const Color steam = Color(0xFFDDDDDD);
  static const Color mainGray = Color(0xfff2f4f6);
  static const Color subGrey = Color(0xFF9CA3AF);
  static final Color subGreyAlfa = Color(0xFF9CA3AF).withAlpha(50);
  static const Color darkGrey = Color(0xff6B7280);
  static const Color mainBlack = Color(0xFF000000);
  static const Color subBlack = Color(0xff1A1A1A);
  static const Color subBlack2 = Color(0xff2A2A2A);
  static const Color mainGreen = Color(0xFF4CAF50);
  static const Color mainRed = Color.fromARGB(255, 255, 102, 0);
  static const Color errorRed = Color.fromARGB(255, 181, 8, 8);
  static const Color lightSecondaryColor = Color(0xFFc7513b);
  static const Color mainBlue = Color(0xFF2196F3);
  static const Color mainLightGold = Color.fromARGB(255, 250, 234, 143);
  static const Color transparent = Color(0x00000000);
  static const Color blueGrey = Color(0xFF607D8B);
  static const Color blue700 = Color(0xFF1976D2);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color black26 = Color(0x42000000);
  static Color withAlpha = const Color(0xFF9E9E9E).withAlpha(30);

  AppColors._();
  static final AppColors _instance = AppColors._();
  factory AppColors() => _instance;
}
