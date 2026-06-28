import 'package:card_holder/common/application/theme/color/theme_color.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class SkeletonSizeWrapper extends StatelessWidget {
  const SkeletonSizeWrapper({
    super.key,
    required this.children,
    this.heightFactor = 0.9,
  });

  final List<Widget> children;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1.0)),

      child: FractionallySizedBox(
        heightFactor: heightFactor,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 35,
                height: 5,
                decoration: boxDecoration(context),
              ),
            ),
            5.h,
            ...children,
          ],
        ),
      ),
    );
  }

  static boxDecoration(BuildContext context) => BoxDecoration(
    color: context.color.outline.withAlpha(220),
    borderRadius: BorderRadius.circular(2.5),
  );
}
