import 'package:card_holder/common/sheets/add_card_sheet.dart';
import 'package:flutter/material.dart';

class CardOpenSheet extends StatelessWidget {
  const CardOpenSheet({super.key, required this.code});
  final String code;

  static void show(BuildContext context, String code) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            width: double.infinity,
            decoration: boxDecoration,
            child: CardOpenSheet(code: code),
          ),
        );
      },
    );
  }

  static const boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Skeleton(children: [Text(code)]);
  }
}
