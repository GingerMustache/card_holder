import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/presentation/widgets/color_wheel/color_wheel.dart';
import 'package:flutter/material.dart';

class ColorWheelWidget extends StatelessWidget {
  const ColorWheelWidget({
    super.key,
    required this.initialColor,
    required this.onChanged,
    required this.isShow,
    this.alignment = const Alignment(0.8, 0.8),
  });
  final int initialColor;
  final void Function(Color)? onChanged;
  final bool isShow;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: fabDecor,
        child:
            isShow
                ? CircleColorPicker(
                  controller: CircleColorPickerController(
                    initialColor: Color(initialColor),
                  ),
                  onChanged: onChanged,
                )
                : const SizedBox(),
      ),
    );
  }
}
