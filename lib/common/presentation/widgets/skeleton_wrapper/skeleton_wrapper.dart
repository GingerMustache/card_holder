import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class SkeletonWrapper extends StatelessWidget {
  const SkeletonWrapper({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: 610 + MediaQuery.of(context).viewInsets.bottom,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.steam.withAlpha(220),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            5.h,
            ...children,
          ],
        ),
      ),
    );
  }
}
