import 'package:flutter/material.dart';

class CardOpenSheet extends StatefulWidget {
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
  State<CardOpenSheet> createState() => _CardOpenSheetState();
}

class _CardOpenSheetState extends State<CardOpenSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [_Skeleton(), Text(widget.code)]);
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(width: 32, height: 1.5, color: Colors.black),
        const SizedBox(height: 27),
      ],
    );
  }
}
