import 'package:card_holder/common/presentation/widgets/color_mark/color_mark.dart';
import 'package:flutter/material.dart';

class ColorMarkWidget extends StatelessWidget {
  const ColorMarkWidget({
    super.key,
    required this.onTap,
    required this.initColor,
    this.alignment = const Alignment(1, -0.9),
  });
  final VoidCallback onTap;
  final int initColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWell(onTap: onTap, child: ColorMark(initColor)),
    );
  }
}
