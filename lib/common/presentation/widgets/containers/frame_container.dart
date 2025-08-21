import 'package:card_holder/common/application/app_settings.dart';
import 'package:flutter/material.dart';

class FrameContainer extends StatelessWidget {
  const FrameContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.steam),

        borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
      ),
      child: child,
    );
  }
}
