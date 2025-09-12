import 'package:card_holder/common/application/app_settings.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.mainWhite,
        splashFactory: null,
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          color: AppColors.mainWhite,

          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
