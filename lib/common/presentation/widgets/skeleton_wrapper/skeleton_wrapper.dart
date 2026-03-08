import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class SkeletonWrapper extends StatelessWidget {
  const SkeletonWrapper({super.key, required this.children, this.ratio = 1.65});

  final List<Widget> children;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 1 / (context.bottomPadding > 0 ? 2.4 : ratio),
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
    color: Theme.of(context).colorScheme.surfaceTint.withAlpha(220),
    borderRadius: BorderRadius.circular(2.5),
  );
}
