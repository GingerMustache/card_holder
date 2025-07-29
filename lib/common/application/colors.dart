part of "app_settings.dart";

class AppColors {
  static const Color mainWhite = Colors.white;
  static const Color mainGray = Color(0xfff2f4f6);
  static const Color subGrey = Color(0xFF9CA3AF);
  static const Color darkGrey = Color(0xff6B7280);
  static const Color mainBlack = Colors.black;
  static const Color subBlack = Color(0xff1A1A1A);
  static const Color suBlack = Color(0xff2A2A2A);
  static const Color mainGreen = Colors.green;
  static const Color mainBlue = Colors.blue;
  static Color withAlpha = Colors.grey.withAlpha(30);

  AppColors._();
  static final AppColors _instance = AppColors._();
  factory AppColors() => _instance;
}
