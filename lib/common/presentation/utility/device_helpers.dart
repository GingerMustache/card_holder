import 'dart:io';

import 'package:card_holder/common/presentation/utility/device_utility.dart';
import 'package:flutter/material.dart';

class DeviceHelpers {
  DeviceHelpers._();

  static double bottomPadding({
    double defaultHeight = 5,
    bool checkMaxHeight = true,
  }) {
    final double height = AppDeviceUtility.getWindowBottomStatusBarHeight();

    if (height == 0) {
      return defaultHeight;
    }
    if (checkMaxHeight) {
      return height > 20 ? 18 : 10;
    }

    return height + 5;
  }

  static double bottomPaddingNew() {
    final double height = AppDeviceUtility.getWindowBottomStatusBarHeight();

    if (Platform.isAndroid) {
      return height;
    }

    return height > 0 ? 10 : 0;
  }

  static double bottomPaddingContext(
    BuildContext context, {
    double defaultHeight = 5,
    bool checkMaxHeight = true,
  }) {
    final double height = MediaQuery.of(context).padding.bottom;

    if (height == 0) {
      return defaultHeight;
    }
    if (checkMaxHeight) {
      return height > 20 ? 18 : 10;
    }

    return height + 5;
  }
}
