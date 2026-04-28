import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class FrameContainer extends StatelessWidget {
  const FrameContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: context.color.outline),

        borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
      ),
      child: child,
    );
  }
}
