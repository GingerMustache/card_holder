import 'package:card_holder/common/extensions/app_extensions.dart';
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
        splashColor: context.color.onSecondary,
        splashFactory: null,
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          color: context.color.onSecondary,

          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
