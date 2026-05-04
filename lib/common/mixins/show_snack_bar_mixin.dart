import 'package:flutter/material.dart';
import 'package:multi_mode_animated_snack/multi_mode_animated_snack.dart';

mixin ShowSnackBarMixin {
  Future<void> showSnackBar(String message, {bool useDelay = false}) async =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (useDelay) {
          Future.delayed(const Duration(milliseconds: 300), () {
            AnimatedSnackBar.show(message: message);
          });
        } else {
          AnimatedSnackBar.show(message: message);
        }
      });
}
