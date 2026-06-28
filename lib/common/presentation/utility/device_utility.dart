import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDeviceUtility {
  AppDeviceUtility._();

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static Future<void> setStatusBarDarkStyle() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getWindowBottomStatusBarHeight() {
    return MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .padding
        .bottom;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getWindowWidth() {
    return MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size
        .width;
  }

  static double getWindowHeight() {
    return MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size
        .height;
  }
}
